import { useEffect } from 'react';
import { createConsumer } from '@rails/actioncable';
import { currentUser } from '@/utils/currentUser';

export interface Payload {
  type: string;
  sender: string;
  message: string;
  [key: string]: unknown;
}

const useActionCable = (channelName: string, onReceived: (data: Payload) => void) => {
  useEffect(() => {
    const wsUrl = import.meta.env.VITE_WS_URL
    const cable = createConsumer(`${wsUrl}?token=${currentUser.token}`);
    const channel = cable.subscriptions.create(channelName, {
      received(data: Payload) {
        onReceived(data);
      }
    });

    return () => {
      channel.unsubscribe();
    };
  }, []);
};

export default useActionCable;
