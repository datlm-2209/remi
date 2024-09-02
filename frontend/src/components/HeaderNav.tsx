import { MonitorPlay } from "lucide-react"
import { Link } from "react-router-dom"

function HeaderNav() {
  return (
    <nav className="flex-col gap-6 text-lg font-medium md:flex md:flex-row md:items-center md:gap-5 md:text-sm lg:gap-6">
      <Link
        to="#"
        className="flex items-center gap-2 text-lg font-semibold md:text-base"
      >
        <MonitorPlay className="h-6 w-6" />
        ONATIMER
      </Link>
    </nav>
  )
}

export default HeaderNav
