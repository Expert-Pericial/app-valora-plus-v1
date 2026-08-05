import js from "@eslint/js";
import globals from "globals";
import reactHooks from "eslint-plugin-react-hooks";
import reactRefresh from "eslint-plugin-react-refresh";
import tseslint from "typescript-eslint";

export default tseslint.config(
  // supabase/functions son Edge Functions de Deno: importan por URL y traen su
  // propio runtime, asi que lintarlas con esta config (globals de navegador y el
  // tsconfig del front) da falsos positivos. Se validan al desplegarlas.
  { ignores: ["dist", "supabase/functions"] },
  {
    extends: [js.configs.recommended, ...tseslint.configs.recommended],
    files: ["**/*.{ts,tsx}"],
    languageOptions: {
      ecmaVersion: 2020,
      globals: globals.browser,
    },
    plugins: {
      "react-hooks": reactHooks,
      "react-refresh": reactRefresh,
    },
    rules: {
      ...reactHooks.configs.recommended.rules,
      "react-refresh/only-export-components": ["warn", { allowConstantExport: true }],
      "@typescript-eslint/no-unused-vars": "off",
      // Deuda tecnica conocida: ~100 usos de `any` heredados (respuestas de
      // Supabase y `catch (e: any)`). Como warning el CI no se bloquea pero
      // siguen apareciendo en el log para irlos limpiando.
      "@typescript-eslint/no-explicit-any": "warn",
    },
  },
);
