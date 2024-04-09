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
