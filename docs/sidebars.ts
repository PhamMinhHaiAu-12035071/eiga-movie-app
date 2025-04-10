  import type {SidebarsConfig} from '@docusaurus/plugin-content-docs';

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */
const sidebars: SidebarsConfig = {
  // By default, Docusaurus generates a sidebar from the docs folder structure
  tutorialSidebar: [
    {
      type: 'category',
      label: 'Getting Started',
      items: ['intro', 'architecture', 'environment-setup'],
    },
    {
      type: 'category',
      label: 'Features',
      items: [
        'features/authentication',
        'features/orders',
      ],
    },
    {
      type: 'category',
      label: 'Development',
      items: [
        'development/testing',
        'development/flutter-gen',
      ],
    },
    {
      type: 'category',
      label: 'Shared Components',
      items: [
        {
          type: 'category',
          label: 'Widgets',
          items: [
            'shared/widgets/index',
            'shared/widgets/responsive-initializer'
          ],
        },
        'shared/styles-themes',
      ],
    },
    'uml-examples',
  ],

  // But you can create a sidebar manually
  /*
  tutorialSidebar: [
    'intro',
    'hello',
    {
      type: 'category',
      label: 'Tutorial',
      items: ['tutorial-basics/create-a-document'],
    },
  ],
   */
};

export default sidebars;
