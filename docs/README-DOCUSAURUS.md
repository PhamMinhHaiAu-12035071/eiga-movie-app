# KSK App Documentation

This folder contains the Docusaurus-powered documentation for the KSK App.

## Getting Started

### Prerequisites

- Node.js (version >= 14)
- npm or yarn

### Local Development

```bash
# Install dependencies
npm install

# Start the development server
npm start
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

### Build

```bash
# Build the static site
npm run build
```

This command generates static content into the `build` directory which can be served using any static contents hosting service.

### Deployment

The documentation site is automatically deployed to GitHub Pages when changes are pushed to the main branch. The deployment is handled by the GitHub Actions workflow defined in `.github/workflows/deploy-docs.yml`.

## Documentation Structure

- `docs/`: Main documentation content (Markdown files)
- `blog/`: Updates and release notes
- `src/`: Custom React components and pages
- `static/`: Static assets like images
- `docusaurus.config.ts`: Main configuration file
- `sidebars.ts`: Sidebar configuration

## Adding Content

### Adding Documentation Pages

1. Create a new Markdown file in the `docs/` directory or a subdirectory
2. Add frontmatter at the top of the file:

```md
---
sidebar_position: 1
title: My New Page
description: Description of the page
---
```

3. Add the content of your page in Markdown format
4. The page will be automatically added to the sidebar

### Adding Blog Posts

1. Create a new Markdown file in the `blog/` directory with the format `YYYY-MM-DD-title.md`
2. Add frontmatter at the top of the file:

```md
---
slug: my-blog-post
title: My Blog Post
authors: [author]
tags: [tag1, tag2]
---
```

3. Add the content of your blog post in Markdown format

## Customization

- **Theme**: Modify `src/css/custom.css` to change the theme colors and styles
- **Components**: Add or modify React components in the `src/components/` directory
- **Pages**: Add or modify React pages in the `src/pages/` directory
- **Configuration**: Modify `docusaurus.config.ts` to change the site configuration

## Learn More

- [Docusaurus Documentation](https://docusaurus.io/docs)
- [Markdown Features](https://docusaurus.io/docs/markdown-features)
- [React Components](https://docusaurus.io/docs/creating-pages)
