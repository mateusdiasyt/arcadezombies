const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'zombie-td-reborn-secret';

function getAuth(req) {
  const auth = req.headers.authorization;
  if (!auth || !auth.startsWith('Bearer ')) return null;
  try {
    return jwt.verify(auth.slice(7), JWT_SECRET);
  } catch (e) {
    return null;
  }
}

module.exports = { JWT_SECRET, getAuth };
