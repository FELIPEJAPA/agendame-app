# Estágio 1: Construir o aplicativo Vue.js
FROM node:lts AS build

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Estágio 2: Servir o aplicativo com Nginx
FROM nginx:alpine

# Copie os arquivos de construção do projeto Vue.js para o diretório de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 90

# Comando padrão para iniciar o servidor Nginx
CMD ["nginx", "-g", "daemon off;"]
