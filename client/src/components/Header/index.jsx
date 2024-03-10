import HeaderMobile from "./HeaderMobile"
import HeaderDesktop from "./HeaderDesktop"

const Header = () => {
  return (
    <div className="fixed top-0 z-10 w-full py-7">
      <HeaderMobile />
      <HeaderDesktop />
    </div>
  )
}

export default Header 