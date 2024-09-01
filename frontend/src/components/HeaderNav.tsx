import { MonitorPlay, Sheet, Menu } from "lucide-react"
import { Link } from "react-router-dom"
import { Button } from "./ui/button"
import { SheetTrigger, SheetContent } from "./ui/sheet"

function HeaderNav() {
  return (
    <>
      <nav className="hidden flex-col gap-6 text-lg font-medium md:flex md:flex-row md:items-center md:gap-5 md:text-sm lg:gap-6">
        <Link
          to="#"
          className="flex items-center gap-2 text-lg font-semibold md:text-base"
        >
          <MonitorPlay className="h-6 w-6" />
          <span>ONATIMER</span>
        </Link>
      </nav>
      <Sheet>
        <SheetTrigger asChild>
          <Button
            variant="outline"
            size="icon"
            className="shrink-0 md:hidden"
          >
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left">
          <nav className="grid gap-6 text-lg font-medium">
            <Link
              to="#"
              className="flex items-center gap-2 text-lg font-semibold"
            >
              <MonitorPlay className="h-6 w-6" />
              <span>ONATIMER</span>
            </Link>
          </nav>
        </SheetContent>
      </Sheet></>)
}

export default HeaderNav
