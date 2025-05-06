import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd());

  return {
    plugins: [react()],
    server: {
      host: '0.0.0.0',
      port: 5173,
      strictPort: true,
      headers: {
        'X-Node-ID': env.VITE_NODE_ID || 'Unknown',
      },
    },
    define: {
      'import.meta.env.VITE_NODE_ID': JSON.stringify(env.VITE_NODE_ID || 'Unknown'),
      'import.meta.env.VITE_API_URL': JSON.stringify(env.VITE_API_URL || ''),
    },
  };
});
