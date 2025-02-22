#!/bin/bash

# Create project folder structure
mkdir -p backend frontend admin database .github/workflows

# Backend structure
mkdir -p backend/{config,controllers,models,routes,middleware,utils}
touch backend/{server.js,package.json,.env.example}

# Frontend structure
mkdir -p frontend/{components,pages,styles,utils,public}
touch frontend/{package.json,.env.example}

# Admin panel structure
mkdir -p admin/{config,database}
touch admin/package.json

# Database folder
mkdir -p database
touch database/seed.js

# GitHub Actions workflow folder
mkdir -p .github/workflows
touch .github/workflows/deploy.yml

# Create GitHub Actions CI/CD Workflow for Vercel & Railway
echo "name: Deploy to Vercel and Railway

on:
  push:
    branches:
      - main

jobs:
  deploy-backend:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Deploy Backend to Railway
        run: curl -X POST -H \"Content-Type: application/json\" -d '{}' ${{ secrets.RAILWAY_DEPLOY_HOOK }}

  deploy-frontend:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Deploy Frontend to Vercel
        run: curl -X POST -H \"Authorization: Bearer ${{ secrets.VERCEL_DEPLOY_HOOK }}\" https://api.vercel.com/v1/integrations/deploy/${{ secrets.VERCEL_PROJECT_ID }}" > .github/workflows/deploy.yml

# Root files
touch {.gitignore,LICENSE,README.md,package.json,docker-compose.yml}

# Add and commit changes to the existing GitHub repository
git add .
git commit -m "Initial project structure setup with CI/CD"
git push origin main

echo "Project structure successfully updated and pushed to GitHub with GitHub Actions CI/CD."
I/CD."
