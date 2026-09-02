// @ts-nocheck
// Supabase Edge Function: openai-chat
// Proxies OpenAI Chat Completions using a server-side secret to avoid
// exposing the API key in the client.

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";

const OPENAI_API_KEY = (Deno as any).env.get("OPENAI_API_KEY");

// supabase-js envia 'apikey' y 'x-client-info' ademas de 'authorization'.
// Si falta cualquiera de ellos aqui, el navegador bloquea el POST en el
// preflight y lo reporta como error de CORS.
const CORS_HEADERS: Record<string, string> = {
  "access-control-allow-origin": "*",
  "access-control-allow-methods": "POST, OPTIONS",
  "access-control-allow-headers":
    "authorization, apikey, content-type, x-client-info, x-supabase-api-version",
  "access-control-max-age": "86400",
};

function jsonResponse(body: unknown, init: ResponseInit = {}): Response {
  return new Response(JSON.stringify(body), {
    headers: {
      ...CORS_HEADERS,
      "content-type": "application/json",
    },
    ...init,
  });
}

serve(async (req: any) => {
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: CORS_HEADERS });
  }

  if (req.method !== "POST") {
    return jsonResponse({ error: "Method not allowed" }, { status: 405 });
  }

  if (!OPENAI_API_KEY) {
    return jsonResponse({ error: "OPENAI_API_KEY not configured" }, { status: 500 });
  }

  let payload: Record<string, unknown>;
  try {
    payload = await req.json();
  } catch (_e) {
    return jsonResponse({ error: "Invalid JSON body" }, { status: 400 });
  }

  // Basic validation: expect model and messages
  const model = payload.model as string | undefined;
  const messages = payload.messages as unknown[] | undefined;

  if (!model || !messages) {
    return jsonResponse({ error: "Missing 'model' or 'messages' in body" }, { status: 400 });
  }

  try {
    const resp = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "content-type": "application/json",
        authorization: `Bearer ${OPENAI_API_KEY}`,
      },
      body: JSON.stringify(payload),
    });

    const data = await resp.json();

    if (!resp.ok) {
      // Pass through error details from OpenAI
      return jsonResponse({ error: data?.error ?? data }, { status: resp.status });
    }

    return jsonResponse(data, { status: 200 });
  } catch (e) {
    console.error("openai-chat error", e);
    return jsonResponse({ error: "Unexpected error calling OpenAI" }, { status: 500 });
  }
});