
import { Star } from "lucide-react"
import {
  Alert,
  AlertDescription,
  AlertTitle,
} from "@/components/ui/alert"
import useActionCable, { Payload } from "@/hooks/useActionCable";
import { useEffect, useState } from "react";
import useVideoStore from "@/stores/videoStore";
import { currentUser } from "@/utils/currentUser";

export function Notifications() {
  const [notifications, setNotifications] = useState<Payload[]>([]);
  const { fetchVideos } = useVideoStore()


  useActionCable('NotificationsChannel', (payload: Payload) => {
    setNotifications(prevNotifications => {
      if (payload.sender == currentUser.username) return [...prevNotifications]

      const newNotification: Payload = {
        type: payload.type,
        sender: payload.sender,
        message: payload.message,
        title: payload.title,
      };
      return [...prevNotifications, newNotification];
    });

    fetchVideos()
  });

  useEffect(() => {
    const timer = setTimeout(() => {
      setNotifications(prevNotifications => prevNotifications.slice(1));
    }, 4444);

    return () => clearTimeout(timer);
  }, [notifications]);


  return (
    <div className="fixed top-20 right-4 space-y-4 z-50 w-[25rem] max-w-full">
      {notifications.map((payload, index) => (
        <div
          key={index}
          className="flex items-start"
        >
          <Alert key={index} variant="default" className="w-full shadow-lg">
            <Star className="h-4 w-4" />
            <AlertTitle>
              <span className="font-bold">{payload.sender}</span>
              <span className="font-normal"> just shared:</span></AlertTitle>
            <AlertDescription>{payload.title as string}</AlertDescription>
          </Alert>
        </div>
      ))}
    </div>
  );
};
export default Notifications;
