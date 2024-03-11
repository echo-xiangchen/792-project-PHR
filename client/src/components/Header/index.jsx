import HeaderMobile from "./HeaderMobile"; // Import the mobile header component
import HeaderDesktop from "./HeaderDesktop"; // Import the desktop header component

// Header component to display either mobile or desktop header based on screen size
const Header = () => {
  return (
      <div className="fixed top-0 z-10 w-full">
        {/* Render the mobile header */}
        <HeaderMobile />

        {/* Render the desktop header */}
        <HeaderDesktop />
      </div>
  );
}

export default Header; // Export the Header component
