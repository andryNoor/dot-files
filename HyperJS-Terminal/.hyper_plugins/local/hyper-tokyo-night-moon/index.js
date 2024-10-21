const backgroundColor = "#222436";
const foregroundColor = "#c8d3f5";

const black = "#1e2030";
const blue = "#82aaff";
const cyan = "#86e1fc";
const green = "#71a6b5";
const magenta = "#c099ff";
const red = "#ff757f";
const white = "#828bb8";
const yellow = "#e0af68";

const lightBlack = "#444a73";
const lightBlue = "#65bcff";
const lightCyan = "#4fd6be";
const lightGreen = "#41a6b5";
const lightMagenta = "#ff007c";
const lightRed = "#c53b53";
const lightWhite = "#acb0d0";
const lightYellow = "#ffc777";

const borderColor = "#101014";
const activeTabBorderBottomColor = "#3d59a1";

const cursorColor = '#00ffc8'; // foregroundColor;
const cursorAccentColor = backgroundColor;

const selectionColor = '#534f40'; // "#2f334d";

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

