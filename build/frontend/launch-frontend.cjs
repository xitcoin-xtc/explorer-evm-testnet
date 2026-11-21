'use strict';
const fs = require('node:fs');
const env = JSON.parse(fs.readFileSync('/app/frontend-public.json', 'utf8'));
for (const [key, value] of Object.entries(env)) {
  if (!key.startsWith('NEXT_PUBLIC_') || typeof value !== 'string') throw new Error('Invalid public configuration');
  process.env[key] = value;
}
const browser = fs.readFileSync('/app/public/assets/envs.js', 'utf8');
const match = browser.match(/^window\.__envs = (.*);\s*$/s);
if (!match || JSON.stringify(JSON.parse(match[1])) !== JSON.stringify(Object.fromEntries(Object.entries(env).sort()))) {
  // Compare maps without depending on JSON formatting.
  if (!match) throw new Error('Browser config missing');
  const b = JSON.parse(match[1]);
  if (Object.keys(b).length !== Object.keys(env).length || Object.keys(env).some(k => b[k] !== env[k])) throw new Error('Server/browser mismatch');
}
require('/app/server.js');
