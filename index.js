import { Telegraf } from 'telegraf';
import { readdir } from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

const bot = new Telegraf('7997979817:AAH4mvEG49x2xg4EW8Dwkhy38RZvftzRPPU');
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const cmds = await readdir(path.join(__dirname, 'commands'));

for (const f of cmds) {
  if (f.endsWith('.js')) {
    const m = await import(path.join(__dirname, 'commands', f));
    m.default(bot);
  }
}

bot.launch();
