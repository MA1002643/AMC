#!/bin/bash

# Create project folder structure
mkdir -p afaaq-mobile/{backend,frontend,admin,database,.github/workflows}

# Backend structure
mkdir -p afaaq-mobile/backend/{config,controllers,models,routes,middleware,utils}
touch afaaq-mobile/backend/{server.js,package.json,.env.example}

# Frontend structure
mkdir -p afaaq-mobile/frontend/{components,pages,styles,utils,public}
touch afaaq-mobile/frontend/{package.json,.env.example}

# Admin panel structure
mkdir -p afaaq-mobile/admin/{config,database}
touch afaaq-mobile/admin/package.json

# Database folder
mkdir -p afaaq-mobile/database

touch afaaq-mobile/database/seed.js

# GitHub Actions workflow folder
mkdir -p afaaq-mobile/.github/workflows
touch afaaq-mobile/.github/workflows/deploy.yml

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
        run: curl -X POST -H \"Authorization: Bearer ${{ secrets.VERCEL_DEPLOY_HOOK }}\" https://api.vercel.com/v1/integrations/deploy/${{ secrets.VERCEL_PROJECT_ID }}" > afaaq-mobile/.github/workflows/deploy.yml

# Root files
touch afaaq-mobile/{.gitignore,LICENSE,README.md,package.json,docker-compose.yml}

# Initialize git repository
cd afaaq-mobile
git init
git add .
git commit -m "Initial project structure setup with CI/CD"
echo "Project structure successfully created and initialized with Git and GitHub Actions CI/CD."
