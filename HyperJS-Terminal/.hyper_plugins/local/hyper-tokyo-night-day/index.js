const backgroundColor = "#e1e2e7"; // ori VSCode: "#d6d8df";
const foregroundColor = "#363c4d"; // "#3760bf"; // ori VSCode: "#363c4d";

const black = "#e1dfcf";
const blue = "#7d5500";
const cyan = "#791e03";
const green = "#8e594a";
const magenta = "#3f6600";
const red = "#008a80";
const white = "#7d7447";
const yellow = "#1f5097";

const lightBlack = "#bbb58c";
const lightBlue = "#9a4300";
const lightCyan = "#b02941";
const lightGreen = "#be594a";
const lightMagenta = "#00ff83";
const lightRed = "#3ac4ac";
const lightWhite = "#534f2f";
const lightYellow = "#003888";

const borderColor = "#efefeb";
const activeTabBorderBottomColor = "#c2a65e"; // "#3d59a1";

const cursorColor = '#ff0037'; // ...-moon: '#00ffc8'; // foregroundColor;
const cursorAccentColor = backgroundColor;

const selectionColor = "#acb0bf";

exports.decorateConfig = (config) =>
  Object.assign({}, config, {
    backgroundColor,
    foregroundColor,
    borderColor,
    cursorColor,
    cursorAccentColor,
    selectionColor,
    colors: {
      black,
      red,
      green,
      yellow,
      blue,
      magenta,
      cyan,
      white,
      lightBlack,
      lightRed,
      lightGreen,
      lightYellow,
      lightBlue,
      lightMagenta,
      lightCyan,
      lightWhite,
    },
    css: `
    /* source: https://github.com/sindresorhus/hyper-snazzy */

    /* Hide title when only one tab */
    .tabs_title {
      display: none !important;
    }

    /* Add a highlight line below the active tab */
    .tab_tab::before {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 1px;
      background-color: ${activeTabBorderBottomColor};
      transform: scaleX(0);
      will-change: transform;
    }
    .tab_tab.tab_active::before {
      transform: scaleX(1);
      transition: all 200ms cubic-bezier(0, 0, 0.2, 1);
    }

    /* Fade the title of inactive tabs and the content of inactive panes */
    .tab_text,
    .term_term {
      opacity: 0.6;
      will-change: opacity;
    }
    .tab_active .tab_text,
    .term_active .term_term {
      opacity: 1;
      transition: opacity 0.12s ease-in-out;
    }

    /* Allow custom css / overrides */
    ${config.css}
  `,
  });

