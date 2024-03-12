/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
    colors: {
      "primary": "#003F4F",
      "secondary": "#2C7B8E",
      "tertiary": "#EAF2F4",
      "grey": "#505F62",
      "lighter-blue" : "#EAF2F4",
      "light-blue": "#D5EFE8",
      "white" : "#FFFFFF",
      "error": "#FF0000",
      "success": "#1AAD19",
      "background": "#A6C8E6",
    },
    screens: {
      'xs': '320px',
      'sm': '640px',
      // => @media (min-width: 640px) { ... }
      'md': '768px',
      // => @media (min-width: 768px) { ... }
      'lg': '1024px',
      // => @media (min-width: 1024px) { ... }
      'xl': '1280px',
      // => @media (min-width: 1280px) { ... }
      '2xl': '1536px',
      // => @media (min-width: 1536px) { ... }
      '3xl': '1920px',
      '4xl': '2560px',
    },
    padding: {
      '1': '0.25rem',
      '2': '0.5rem',
      '3': '0.75rem',
      '4': '1rem',
      '5': '1.25rem',
      '6': '1.5rem',
      '7': '1.75rem',
      '8': '2rem',
      '9': '2.25rem',
      '10': '2.5rem',
      '12': '3rem',
      '16': '4rem',
      '18': '4.5rem',
      '24': '6rem',
      '32': '8rem',
      '36': '9rem',
      '40': '10rem',
      '45': '11.25rem',
      '48': '12rem',
      '56': '14rem',
      '64': '16rem',
      '72': '18rem',
      '80': '20rem',
      '88': '22rem',
      '96': '24rem',
      '104': '26rem',
      '112': '28rem',
    },
    boxShadow: {
      card : "rgba(0, 0, 0, 0.35) 0px 5px 15px",
      product: "rgba(0,0,0,0.08) 0 4px 15px",
    },
  },
  plugins: [],
}