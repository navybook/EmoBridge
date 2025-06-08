const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,html}',
    './app/assets/stylesheets/**/*.css'
  ],
  theme: {
    extend: {
      fontFamily: {
        vibes: ['Great Vibes'],
        yomogi: ['Yomogi'],
      },
      animation: {
        "tracking-in-expand": "tracking-in-expand 0.7s cubic-bezier(0.215, 0.610, 0.355, 1.000)   both"
      },
      keyframes: {
          "tracking-in-expand": {
              "0%": {
                  "letter-spacing": "-.5em",
                  opacity: "0"
              },
              "40%": {
                  opacity: ".6"
              },
              to: {
                  opacity: "1"
              }
          }
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('daisyui'),
  ],
  daisyui: {
    themes: ["valentine"],
  }
}
