FROM mcr.microsoft.com/playwright:v1.48.0-jammy

WORKDIR /app

# Copia i file package.json e package-lock.json
COPY package*.json ./

# Installa le dipendenze
RUN npm ci --only=production

# ✅ Installa i browser Playwright in fase di build
RUN npx playwright install

# Copia il resto del progetto
COPY . .

# Inizializza il database (se serve)
RUN mkdir -p /app && touch /app/promemoria.db

# Costruisci l'app Next.js
RUN npm run build

# Esponi la porta
EXPOSE 3000

# Imposta le variabili d'ambiente
ENV NODE_ENV=production
ENV PORT=3000

# Avvia l'applicazione
CMD ["npm", "start"]
