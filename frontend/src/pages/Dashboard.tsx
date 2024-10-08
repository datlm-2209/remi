import ShareDialog from "@/components/ShareDialog";
import VideoCard from "@/components/VideoCard";
import useVideoStore from "@/stores/videoStore";
import { isAuthenticated } from "@/utils/currentUser";
import { useEffect } from "react";

function Dashboard() {
  const { fetchVideos, videos } = useVideoStore()

  useEffect(() => {
    fetchVideos();
  }, [fetchVideos]);

  return (
    < div className="grid gap-6" >
      <div className="flex justify-between pb-2 border-b">
        <h2 className="mt-10 scroll-m-20 text-3xl font-semibold transition-colors first:mt-0">
          Videos
        </h2>
        {isAuthenticated() ? <ShareDialog /> : ''}
      </div>
      {videos.map((video) => <VideoCard video={video} key={video.id} />)}
    </div>
  );
}
export default Dashboard
