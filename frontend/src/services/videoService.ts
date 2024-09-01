import { AxiosResponse } from 'axios';
import api from '@/services/baseService';
import { VIDEO_PATH } from '@/utils/path';

export interface CreateVideoData {
  url: string;
}

export class VideoService {
  async fetchVideos(): Promise<AxiosResponse> {
    const response = await api.get(VIDEO_PATH.LIST);
    return response;
  }

  async createVideo(data: CreateVideoData): Promise<AxiosResponse> {
    const response = await api.post(VIDEO_PATH.CREATE, { video: data });
    return response;
  }
}
