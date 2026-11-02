# CSE 340 Service Network

Starter project for the CSE 340 initial site assignment.

## Requirements
- Node.js (LTS recommended)
- npm

## Run locally
1. Open this folder in VS Code.
2. In the terminal, run `npm install`.
3. Copy `.env.example` to `.env` (optional; the default port is 5500).
4. Run `npm run dev`.
5. Visit `http://localhost:5500`.

## Pages
- `/` — Home
- `/organizations` — Organizations
- `/projects` — Service Projects
- `/categories` — Service Project Categories

## GitHub
The `.gitignore` file excludes `.env` and `node_modules`. Commit `.env.example`, never `.env`.

## Render deployment
1. Push the project to a GitHub repository.
2. In Render, create a **New Web Service** and connect that repository.
3. Choose **Node** as the runtime.
4. Set Build Command to `npm install`.
5. Set Start Command to `npm start`.
6. Deploy, then open the generated Render URL and test all four routes.

This is a starter version. Review the code and make sure you can explain it before submitting.
