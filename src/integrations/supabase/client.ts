import { createClient } from '@supabase/supabase-js';
import type { Database } from './types';

let SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL || 'https://dummy.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = import.meta.env.VITE_SUPABASE_PUBLISHABLE_KEY || 'dummy';

// Protect against placeholder values that cause URL malformed crashes
if (SUPABASE_URL.includes('<') || SUPABASE_URL.includes('>')) {
  SUPABASE_URL = 'https://dummy.supabase.co';
}

// Removemos el throw Error para que la app no tire pantalla blanca si faltan variables
// if (!SUPABASE_URL || !SUPABASE_PUBLISHABLE_KEY) {
//   throw new Error('Missing Supabase environment variables');
// }

// Import the supabase client like this:
// import { supabase } from "@/integrations/supabase/client";

export const supabase = createClient<Database>(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
  auth: {
    storage: localStorage,
    persistSession: true,
    autoRefreshToken: true,
  }
});