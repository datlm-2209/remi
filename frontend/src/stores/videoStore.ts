import { create } from 'zustand';
import { videoService } from '@/services';
import { AxiosError } from 'axios';
import { CreateVideoData } from '@/services/videoService';
import { Video } from '@/types/video';
import { User } from '@/types/user';

interface AuthState {
  videos: Video[];
  video: Video | null;
  error: string | null;
  fetchVideos: () => Promise<void>;
  createVideo: (data: CreateVideoData) => Promise<void>;
}

interface VideoData {
  data: {
    id: string;
    type: string;
    attributes: Omit<Video, 'user'>;
    relationships: {
      user: {
        data: {
          id: string;
          type: string;
        };
      };
    };
  }[];
  included: {
    id: string;
    type: string;
    attributes: User;
  }[];
}

const useVideoStore = create<AuthState>((set) => ({
  videos: [],
  video: null,
  error: null,
  fetchVideos: async () => {
    try {
      const response = await videoService.fetchVideos();
      const videos = extractData(response.data)
      set({  videos, error: null  });
    } catch(error) {
      if (error instanceof AxiosError && error.response) {
        set({ error: error.response.data});
      } else {
        set({error: "Fetch Video Failed!"})
      }
    }
  },

  createVideo: async (data: CreateVideoData) => {
    try {
      await videoService.createVideo(data);
    } catch(error) {
      if (error instanceof AxiosError && error.response) {
        set({ error: error.response.data});
      } else {
        set({error: "Create Video Failed!"});
      }
    }
  },

  clearError: () => {
    set({ error: null});
  }
}));

const extractData = (data: VideoData): Video[] => {
  const userMap = new Map();
  data.included.forEach(user => {
    userMap.set(user.id, user.attributes);
  });

  const videos = data.data.map(video => {
    const userId = video.relationships.user.data.id;
    const user = userMap.get(userId);
    return {
      ...video.attributes,
      user
    };
  });

  return videos
}

export default useVideoStore
