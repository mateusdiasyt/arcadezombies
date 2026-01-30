const fs = require('fs');
const path = require('path');

const root = path.join(__dirname, '..');
const publicDir = path.join(root, 'public');
const swfName = 'zombie_td_reborn_modificado.swf';
const src = path.join(root, swfName);
const dest = path.join(publicDir, swfName);

if (!fs.existsSync(publicDir)) {
  fs.mkdirSync(publicDir, { recursive: true });
}
if (fs.existsSync(src)) {
  fs.copyFileSync(src, dest);
  console.log('SWF copiado para public/', swfName);
} else {
  console.warn('Aviso: SWF não encontrado em', src, '- faça a recompilação ou copie manualmente.');
}
