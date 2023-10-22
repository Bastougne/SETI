class CChrono
{
  LARGE_INTEGER f, t0;
public:
  CChrono()
  {
	::QueryPerformanceFrequency(&f);
    ::QueryPerformanceCounter(&t0);
  }
  void Reset() {::QueryPerformanceCounter(&t0);}
  DWORD GetDelayMs()
  {
    LARGE_INTEGER t1;
    ::QueryPerformanceCounter(&t1);
    return DWORD((1000*(t1.QuadPart-t0.QuadPart))/f.QuadPart);
  }
  DWORD GetDelayUs()
  {
    LARGE_INTEGER t1;
    ::QueryPerformanceCounter(&t1);
    return DWORD((1000000*(t1.QuadPart-t0.QuadPart))/f.QuadPart);
  }
  void GetDelayMs(TCHAR* str, DWORD div=1) { wsprintf(str,L"Delai = %lu ms",GetDelayMs()/div); }
  void GetDelayUs(TCHAR* str, DWORD div=1) { wsprintf(str,L"Delai = %lu us",GetDelayUs()/div); }
  void ShowDelayMs(DWORD div=1)
  {
    TCHAR buf[128];
    GetDelayMs(buf,div);
    ::MessageBox(0,buf,L"Chrono",MB_OK);
  }
  void ShowDelayUs(DWORD div=1)
  {
    TCHAR buf[128];
    GetDelayUs(buf,div);
    ::MessageBox(0,buf,L"Chrono",MB_OK);
  }
};