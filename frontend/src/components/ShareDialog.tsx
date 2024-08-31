import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { Form, FormField, FormItem, FormLabel, FormControl, FormMessage } from "./ui/form";

const shareVideoSchema = z.object({
  url: z.string().url().min(1),
});

type shareVideoFormValues = z.infer<typeof shareVideoSchema>

function ShareDialog() {
  const form = useForm<z.infer<typeof shareVideoSchema>>({
    resolver: zodResolver(shareVideoSchema),
    defaultValues: {
      url: "",
    },
  })

  const onSubmit = async (data: shareVideoFormValues) => {
    console.log(data);
  };

  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button >Share new video</Button>
      </DialogTrigger>
      <DialogContent className="w-lg">
        <DialogHeader>
          <DialogTitle>Share new video</DialogTitle>
          <DialogDescription>
            Share new video to everyone.
          </DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 pt-4">
          <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)}>
              <FormField
                control={form.control}
                name="url"
                render={({ field }) => (
                  <FormItem className="grid gap-2">
                    <FormLabel>Youtube URL</FormLabel>
                    <FormControl>
                      <Input
                        id="url"
                        placeholder="https://www.youtube.com/watch?v=dQw4w9WgXcQ"
                        {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <DialogFooter className="mt-6">
                <Button type="submit" >Share</Button>
              </DialogFooter>
            </form>
          </Form>
        </div>
      </DialogContent>
    </Dialog >
  )
}

export default ShareDialog
