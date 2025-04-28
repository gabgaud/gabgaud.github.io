import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';


const config: Config = {
  title: 'Le site de ton prof',
  tagline: 'L\'informatique simplifié',
  favicon: 'img/hipster.svg',

  // Set the production url of your site here
  url: 'https://www.tonprof.ca',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'gabgaud', // Usually your GitHub org/user name.
  projectName: 'www.tonprof.ca', // Usually your repo name.

  onBrokenLinks: 'warn',
  onBrokenMarkdownLinks: 'warn',
  deploymentBranch: "gh-pages",
  trailingSlash: false,

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: "fr",
    locales: ["fr"],
  },

  plugins: [require.resolve("docusaurus-plugin-image-zoom")],

  presets: [
    [
      'classic',
      {
        docs: {
          routeBasePath: '/',
          sidebarPath: './sidebars.ts',
          admonitions: {
            keywords: [
              'info',
              'success',
              'danger',
              'note',
              'tip',
              'warning',
              'important',
              'caution',
              'security',
              'cadenas',
            ],
          },
        },
        blog: false,

        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],
  markdown: {
    mermaid: true,
  },
  themes: ['@docusaurus/theme-mermaid'],
  themeConfig: {
    zoom: {
      selector: '.markdown :not(em) > img',
      config: {
        // options you can specify via https://github.com/francoischalifour/medium-zoom#usage
        background: {
          light: 'rgb(255, 255, 255)',
          dark: 'rgb(50, 50, 50)'
        }
      }
    },
    colorMode: {
      defaultMode: 'dark',
      disableSwitch: false,
      respectPrefersColorScheme: false,
    },
    // Replace with your project's social card
    image: 'img/docusaurus-social-card.jpg',
    docs:{
      sidebar:{
        hideable: true,
      },
    },
    navbar: {
      title: 'Accueil',
      logo: {
        alt: 'Logo',
        src: 'img/hipster.svg',
        srcDark: 'img/hipster_w.svg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'OsSidebar',
          position: 'left',
          label: 'Systèmes d\'exploitation',
        },
        {
          type: 'docSidebar',
          sidebarId: 'Serveur1Sidebar',
          position: 'left',
          label: 'Serveurs 1',
        },
        {
          href: 'https://github.com/facebook/docusaurus',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    tableOfContents: {
      minHeadingLevel: 2,
      maxHeadingLevel: 5,
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Sections',
          items: [
            {
              label: 'Systèmes d\'exploitation',
              to: 'OS/Mot%20de%20section',
            },
            {
              label: 'Serveurs 1',
              to: 'Serveurs 1/Mot%20de%20section',
            },
          ],
        },
        {
          title: 'Social',
          items: [
            {
              label: 'LinkedIn',
              href: 'https://www.linkedin.com/in/gabriel-gaudreault-9ba67151/',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/gabgaud',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} Gabriel Gaudreault.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['powershell', 'bash', 'shell-session', 'batch', 'json'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
