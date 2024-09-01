import { User } from "@/types/user";

export interface Video {
  id: string | number;
  url: string;
  embedUrl: string;
  title: string;
  description: string;
  user: User
}
