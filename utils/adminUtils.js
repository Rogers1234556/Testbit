import fs from 'fs/promises';
const ADMINS_PATH = './admins.json';

export async function loadAdmins() {
  try {
    const txt = await fs.readFile(ADMINS_PATH, 'utf8');
    return JSON.parse(txt);
  } catch {
    await fs.writeFile(ADMINS_PATH, '[]', 'utf8');
    return [];
  }
}

export async function saveAdmins(admins) {
  await fs.writeFile(ADMINS_PATH, JSON.stringify(admins, null, 2), 'utf8');
}

export async function getAdminLevel(userId) {
  const admins = await loadAdmins();
  const a = admins.find(x => String(x.id) === String(userId));
  return a?.level ?? 0;
}

export async function hasLevel(userId, minLevel) {
  return (await getAdminLevel(userId)) >= minLevel;
}

export async function setAdminLevel(userId, level, tag = '') {
  const admins = await loadAdmins();
  const idx = admins.findIndex(x => String(x.id) === String(userId));
  if (idx >= 0) {
    admins[idx].level = level;
    if (tag) admins[idx].tag = tag;
  } else {
    admins.push({ id: String(userId), level, tag });
  }
  await saveAdmins(admins);
}

export async function removeAdmin(userId) {
  let admins = await loadAdmins();
  admins = admins.filter(x => String(x.id) !== String(userId));
  await saveAdmins(admins);
}
