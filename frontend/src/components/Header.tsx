import { Link } from "react-router-dom"
import { CircleUser } from "lucide-react"

import { Button } from "@/components/ui/button"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import HeaderNav from "@/components/HeaderNav"
import { currentUser, isAuthenticated } from "@/utils/currentUser"
import useAuthStore from "@/stores/authStore"

function Header() {
  const { logout } = useAuthStore();
  const handleLogout = async () => {
    await logout()
  };

  return (
    <header className="sticky top-0 flex h-16 items-center gap-4 border-b bg-background px-4 md:px-6">
      <HeaderNav />
      <div className="flex w-full items-center gap-4 md:ml-auto md:gap-2 lg:gap-4">
        <div className="ml-auto sm:flex-initial">
          {isAuthenticated() && currentUser.username}
        </div>
        {isAuthenticated() ?
          (
            <>
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="secondary" size="icon" className="rounded-full">
                    <CircleUser className="h-5 w-5" />
                    <span className="sr-only">Toggle user menu</span>
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem onClick={handleLogout}>Logout</DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </>

          ) : (
            <>
              <Button variant="outline" asChild>
                <Link to="/login">Login</Link>
              </Button>
              <Button asChild>
                <Link to="/login">Become a member</Link>
              </Button>
            </>
          )
        }
      </div>
    </header>
  )
}

export default Header
