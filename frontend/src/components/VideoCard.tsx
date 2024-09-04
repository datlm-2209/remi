import { useState } from "react";
import { Card, CardContent } from "./ui/card";
import { Video } from "@/types/video";

type Props = {
  video: Video;
}

function VideoCard({ video }: Props) {
  const [isExpanded, setIsExpanded] = useState(false);

  const toggleDescription = () => {
    setIsExpanded(!isExpanded);
  };

  return (
    <Card id={`dashboard-chunk-${video.id}`} x-chunk={`dashboard-chunk-${video.id}`}>
      <CardContent className="flex flex-col md:flex-row items-start gap-6 pt-6">
        <div className="w-full md:w-2/3">
          <iframe
            className="w-full aspect-video rounded"
            src={video.embedUrl}
            title={video.title}
            frameBorder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            referrerPolicy="strict-origin-when-cross-origin"
            allowFullScreen
          ></iframe>
        </div>

        <div className="w-full md:w-1/3 flex flex-col justify-start">
          <h3 className="scroll-m-20 text-2xl font-semibold tracking-tight">
            {video.title}
          </h3>
          <p className="leading-7">
            Shared by{" "}
            <a
              href="#"
              className="font-medium text-primary underline underline-offset-4"
            >
              {video.user.username}
            </a>
          </p>
          <blockquote className="mt-6 text-xs border-l-2 pl-6 italic">
            {isExpanded ? video.description : `${video.description.slice(0, 500)}...`}
          </blockquote>
          <button
            onClick={toggleDescription}
            className="mt-2 text-sm text-primary underline underline-offset-4 text-left"
          >
            {isExpanded ? "Show less" : "Show more"}
          </button>
        </div>
      </CardContent>
    </Card>
  );
}

export default VideoCard;
