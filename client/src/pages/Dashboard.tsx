// import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  // CardFooter,
} from "@/components/ui/card"
// import { ArrowDown, ArrowUp } from "lucide-react";

function Dashboard() {
  return (
    <div className="grid gap-6">
      <h2 className="mt-10 scroll-m-20 border-b pb-2 text-3xl font-semibold tracking-tight transition-colors first:mt-0">
        The King's Plan
      </h2>
      <Card x-chunk="dashboard-04-chunk-1">
        <CardContent className="flex flex-col md:flex-row items-start gap-6 pt-6">
          <div className="w-full md:w-2/3">
            <iframe
              className="w-full aspect-video rounded"
              src="https://www.youtube.com/embed/CrtoyB2fcMI?si=uhpKc2mr45g9QE4v"
              title="YouTube video player"
              frameBorder="0"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
              referrerPolicy="strict-origin-when-cross-origin"
              allowFullScreen
            ></iframe>
          </div>

          <div className="w-full md:w-1/3 flex flex-col justify-start">
            <h3 className="scroll-m-20 text-2xl font-semibold tracking-tight">
              The Joke Tax
            </h3>
            <p className="leading-7">
              Shared by{" "}
              <a
                href="#"
                className="font-medium text-primary underline underline-offset-4"
              >
                John Doe
              </a>
            </p>
            <blockquote className="mt-6 border-l-2 pl-6 italic">
              Lorem ipsum dolor sit amet consectetur adipisicing elit.
              Laboriosam voluptas repudiandae voluptate voluptatibus officia quidem vitae at fuga mollitia porro, nostrum eos, neque, consequatur aut.
              Omnis voluptatum neque accusamus veritatis.
            </blockquote>
          </div>
        </CardContent>

        {/* Footer */}
        {/* <CardFooter className="border-t px-6 py-4">
          <Button
            variant="link"
            size="icon"
            className="mr-2"
          >
            <ArrowUp className="h-5 w-5 mr-2" />12
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
          <Button
            variant="link"
            size="icon"
            className="mr-2"
          >
            <ArrowDown className="h-5 w-5 mr-2" />1
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </CardFooter> */}
      </Card>
    </div>
  );
}
export default Dashboard
