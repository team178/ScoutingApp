// With the Tauri API npm package:
import { invoke } from '@tauri-apps/api/tauri'

const test = () => {
    invoke('print_db')
    console.log('test');
};

export { test };