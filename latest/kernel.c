void main(){
    // Just be happy with writing X at the top left corner lel
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'X';
}