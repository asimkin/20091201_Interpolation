{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{           Copyright (c) 2009, Simkin A.V.             }
{                                                       }
{*******************************************************}
{         Library Version 0.8.7 from 25.04.2009         }
{*******************************************************}
{       'Image Extension Works' from 25.04.2009         }
{*******************************************************}
unit ImgLibImageExt;
 { ������ ��������� ����������� }
interface {�������� ��������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  Windows, SysUtils,                    // ��������� ������
  Graphics, JPEG,                       // �������������� ������ ������ � ��������
  ImgLibTypes;                          // ������ ���������� IMG LIB

  ////////////////////////////////////////////////////////////
  // �������� ��������� � ������� ������
  //
  //////////////////////////////////////////////////////
  // �������� ��������� � ������� ���������
  //// ����������� �������� ////
  // �������� �����
  function iOpenFromFile(FileName: TFileName): TBitMap; stdcall;
  // ���������� �����
  function iSaveToFile(var BMP: TBitmap; FileName: TFileName): Boolean; overload; stdcall;
  function iSaveToFile(var JPG: TJPEGImage; FileName: TFileName): Boolean; overload; stdcall;

  //// ����������� ////
  function iJPEGtoBMP(FileName: TFileName; SaveToFile: Boolean = True;
                      FileSaveName: TFileName = ''; FilePatch: TFileName = ''):
                      TFileName; overload; stdcall;
  function iJPEGtoBMP(var JPEG: TJPEGImage): TBitmap; overload; stdcall;

  //// ������ ////
  // ��������� �������
  function iGetSize(FileName: TFileName): Shortstring; overload; stdcall;
  procedure iGetSize(FileName: TFileName; out W, H: Word); overload; stdcall;

  function iCreateBMPwithFontSymbol(Symbol: Char; Size: Integer = 12; FName: String = 'Tahoma';
                                  FStyles: TFontStyles = []): TBitMap; stdcall;
  // ��������� �������
  function iResize(BMP: TBitMap; newH, newW: Cardinal; ResizeType: TResizeType = fBilinearSpline;
                   Monochrome: Boolean = False): TBitMap; stdcall;

  //////////////////////////////////////////////////////
  // ��������� � ������� �����������
  //// ����������� � ��� ////
  // ����������� � ������(�)
  procedure iBMPtoArray(var BMP: TBitMap; out Result: TImageArray); overload; stdcall;
  procedure iBMPtoArray(var BMP: TBitMap; out RArr, GArr, BArr: TImageArray); overload; stdcall;
  procedure iBMPtoArray(var BMP: TBitMap; out Result: TDDouble2Array); overload; stdcall;
  procedure iBMPtoArray(var BMP: TBitMap; out RArr, GArr, BArr: TDDouble2Array); overload; stdcall;

  //// ����������� �� ���� ////
  // ����������� �� �������
  function iArrayToBMP(var Arr: TImageArray): TBitMap; overload; stdcall;
  function iArrayToBMP(var Arr: TDDouble2Array): TBitMap; overload; stdcall;
  function iArrayToBMP(var Arr: TImagesArray): TBitMap; overload; stdcall;
  function iArrayToBMP(var Arr: TSymbolsArray): TBitMap; overload; stdcall;
  // ����������� �� ��������
  function iArraysToBMP(var RArr, GArr, BArr: TImageArray): TBitMap; overload; stdcall;
  function iArraysToBMP(var RArr, GArr, BArr: TDDouble2Array): TBitMap; overload; stdcall;

implementation {���������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  Classes,                              // ��������� ������
  Math,                                 // �������������� ������
  QPixels,                              // ������� ������ ������ � ��������
  SplineLibLinear, SplineLibBilinear,   // ������� ������ ���������� ��������
  ImgLibArrayExt;                       // ������ ���������� IMG LIB

////////////////////////////////////////////////////////////////////////////////
//// ��������� ��������� � �������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
// ��������� ��������� � �������
////////////////////////////////////////////////////////////////

// ������� ���������� ���� � ��� ����� Windows
 function sysGetTempPath: String;
 var Buffer: array[0..1023] of Char;
 begin
  SetString(Result, Buffer, GetTempPath(Sizeof(Buffer) - 1, Buffer));
 end;//function c_GetTempPath();

// ������� ������ ������ ���� ������ �����
 function sysReadFileMWord(f: TFileStream): word;
 type TMotorolaWord = record
        case byte of
          0: (Value: word);
          1: (Byte1, Byte2: byte);
        end;
 var MW: TMotorolaWord;
 begin
  { It would probably be better to just read these two bytes in normally }
  { and then do a small ASM routine to swap them. But we aren't talking }
  { about reading entire files, so I doubt the performance gain would be }
  { worth the trouble.}
  f.read(MW.Byte2, SizeOf(Byte));
  f.read(MW.Byte1, SizeOf(Byte));
  Result := MW.Value;
 end; // sysReadFileMWord();

////////////////////////////////////////////////////////////////
// �������������� ��������� � ������� ������ � �������������
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ��������� �������
//

// ��������� ��������� ������� JPG �����������
 procedure GetJPGSize(const sFile: string; out wWidth, wHeight: word);
 const ValidSig : array[0..1] of byte = ($FF, $D8);
       Parameterless = [$01, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7];
 var Sig: array[0..1] of byte;
     f: TFileStream;
     x: integer;
     Seg: byte;
     Dummy: array[0..15] of byte;
     Len: word;
     ReadLen: LongInt;
 Begin
  FillChar(Sig, SizeOf(Sig), #0);
  f := TFileStream.Create(sFile, fmOpenRead);
  try
    ReadLen := f.read(Sig[0], SizeOf(Sig));
    for x := Low(Sig) to High(Sig) do
      if Sig[x] <> ValidSig[x] then
        ReadLen := 0;
    if ReadLen > 0 then
    begin
      ReadLen := f.read(Seg, 1);
      while (Seg = $FF) and (ReadLen > 0) do
      begin
        ReadLen := f.read(Seg, 1);
        if Seg <> $FF then begin
          if (Seg = $C0) or (Seg = $C1) then begin
            ReadLen := f.read(Dummy[0], 3);
            { don't need these bytes }
            wHeight := sysReadFileMWord(f);
            wWidth  := sysReadFileMWord(f);
          end
          else begin
            if not (Seg in Parameterless) then begin
              Len := sysReadFileMWord(f);
              f.Seek(Len-2, 1);
              f.read(Seg, 1);
            end
            else Seg := $FF;
            { Fake it to keep looping. }
          end;
        end;
      end;
    end;
  finally
    f.Free;
  end;
 End; // GetJPGSize();

// ��������� ��������� ������� PNG �����������
 procedure GetPNGSize(const sFile: string; var wWidth, wHeight: word);
 type TPNGSig = array[0..7] of byte;
 const ValidSig: TPNGSig = (137,80,78,71,13,10,26,10);
 var Sig: TPNGSig;
     f: tFileStream;
     x: integer;
 Begin
  FillChar(Sig, SizeOf(Sig), #0);
  f := TFileStream.Create(sFile, fmOpenRead);
  try
    f.read(Sig[0], SizeOf(Sig));
    for x := Low(Sig) to High(Sig) do
      if Sig[x] <> ValidSig[x] then exit;
    f.Seek(18, 0);
    wWidth  := sysReadFileMWord(f);
    f.Seek(22, 0);
    wHeight := sysReadFileMWord(f);
  finally
    f.Free;
  end;
 End; // GetPNGSize();

// ��������� ��������� ������� GIF �����������
 procedure GetGIFSize(const sGIFFile: string; var wWidth, wHeight: word);
 type TGIFHeader = record
        Sig: array[0..5] of char;
        ScreenWidth, ScreenHeight: word;
        Flags, Background, Aspect: byte;
      end;
      TGIFImageBlock    = record
        Left, Top, Width, Height: word;
        Flags: byte;
      end;
 var f: file;
     Header: TGifHeader;
     ImageBlock: TGifImageBlock;
     nResult: integer;
     x: integer;
     c: char;
     DimensionsFound: boolean;
 Begin
  wWidth  := 0;
  wHeight := 0;
  if sGifFile = '' then exit;
  {$I-}
  FileMode := 0; { read-only }
  AssignFile(f, sGifFile);
  reset(f, 1);
  if IOResult <> 0 then {Could not open file }
    exit; { Read header and ensure valid file. }
  BlockRead(f, Header, SizeOf(TGifHeader), nResult);
  if (nResult <> SizeOf(TGifHeader)) or (IOResult <> 0)
  or (StrLComp('GIF', Header.Sig, 3) <> 0) then begin
    { Image file invalid }
    close(f);
    exit;
  end; { Skip color map, if there is one }
  if (Header.Flags and $80) > 0 then begin
    x := 3 * (1 shl ((Header.Flags and 7) + 1));
    Seek(f, x);
    if IOResult <> 0 then
    begin { Color map thrashed }
      close(f);
      exit;
    end;
  end;
  DimensionsFound := False;
  FillChar(ImageBlock, SizeOf(TGIFImageBlock), #0);
  { Step through blocks. }
  BlockRead(f, c, 1, nResult);
  while (not EOF(f)) and (not DimensionsFound) do begin
    case c of
      ',': { Found image }
      begin
        BlockRead(f, ImageBlock, SizeOf(TGIFImageBlock), nResult);
        if nResult <> SizeOf(TGIFImageBlock) then
        begin { Invalid image block encountered }
          close(f);
          exit;
        end;
        wWidth := ImageBlock.Width;
        wHeight := ImageBlock.Height;
        DimensionsFound := True;
      end;
      'y' : { Skip }
      begin
        { NOP }
      end;
      { nothing else. just ignore }
    end;
    BlockRead(f, c, 1, nResult);
  end;
  close(f);
  {$I+}
 End; // GetGIFSize();



////////////////////////////////////////////////////////////////////////////////
//// �������������� ��������� � �������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
// �������� ��������� � ������� ���������
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ����������� ��������/����������
//

//////////////////////////////////////////////////////
// �������� �����

// ������� ��� �������� BMP, JPG ����� �� ����
// ���������:
//  FileName - ���� � �����
// ������������ ��������:
//  TBitmap
 function iOpenFromFile(FileName: TFileName): TBitMap;
 Var bmp     : TBitMap;
     jpeg    : TJPEGImage;
     FileExt : ShortString;
 Begin
  bmp     := TBitmap.Create;
  FileExt := ExtractFileExt(FileName);
  if Uppercase(FileExt) = '.BMP' then begin
    Try
      bmp.LoadFromFile(FileName);
    Finally
      Result := bmp;
    End;
  end
  else if Uppercase(FileExt) = '.JPG' then begin
    // �����������
    jpeg := TJPEGImage.Create;
    try
      jpeg.CompressionQuality := 100; {Default Value}
      jpeg.LoadFromFile(FileName);
      bmp := TBitmap.Create;
      try
        bmp.Assign(jpeg);
      finally
        Result := bmp;
      end;
    finally
      jpeg.Free;
    end; // try
  end
  else Result := nil;
 End; // function iOpenFromFile();

//////////////////////////////////////////////////////
// ���������� �����

// ������� ��� ���������� BMP ����� �� ����
// ���������:
//  FileName - ���� � �����
// ������������ ��������:
//  Boolean - ����������� ��� ���?
 function iSaveToFile(var BMP: TBitMap; FileName: TFileName): Boolean;
 Var FileExt: ShortString;
 Begin
  Result  := True;
  FileExt := ExtractFileExt(FileName);
  if FileExt = '' then begin
    try
      BMP.SaveToFile(FileName + '.BMP');
    except
      Result := False;
    end;
  end
  else if Uppercase(FileExt) = '.BMP' then begin
    Try
      BMP.SaveToFile(FileName);
    except
      Result := False;
    End;
  end
  else begin
    Result := False;
  end;
 End; // function iSaveToFile();

// ������� ��� ���������� JPG ����� �� ����
// ���������:
//  FileName - ���� � �����
// ������������ ��������:
//  Boolean - ����������� ��� ���?
 function iSaveToFile(var JPG: TJPEGImage; FileName: TFileName): Boolean;
 Var FileExt: ShortString;
 Begin
  Result  := True;
  FileExt := ExtractFileExt(FileName);
  if FileExt = '' then begin
    try
      JPG.SaveToFile(FileName + '.JPG');
    except
      Result := False;
    end;
  end
  else if Uppercase(FileExt) = '.JPG' then begin
    Try
      JPG.SaveToFile(FileName);
    except
      Result := False;
    End;
  end
  else begin
    Result := False;
  end;
 End; // function iSaveToFile();


////////////////////////////////////////////////////////////
// �����������
//

// ������� ��� ����������� jpg 2 bmp
// ���� ��������� ���� � ��������� �����
// ���� ��������� � tmp �����
// ���������:
//  FileName      - ���� � ����� (jpg)
//  SaveToFile    - ���������� ��������� �� ����
//  FileSaveName  - ��� ������������ ����� ��� ����������
//  FilePatch     - ���� ������������ �����
// ������������ ��������:
//  TFileName
 function iJPEGtoBMP(FileName: TFileName; SaveToFile: Boolean = True;
                     FileSaveName: TFileName = ''; FilePatch: TFileName = ''): TFileName;
 Var jpeg         : TJPEGImage;
     bmp          : TBitmap;
     FileFullPatch: TFileName;
 Begin
  // ����������� ��������� �� ���������
  if SaveToFile then begin
    If FilePatch = '' Then // ��������� � tmp
      FilePatch := sysGetTempPath;
    If FileSaveName = '' Then // ��� jpg
      FileSaveName := ExtractFileName(FileName);
    FileFullPatch := FilePatch + ChangeFileExt(FileSaveName, '.bmp');
  end; //IF SaveToFile Then
  // �����������
  jpeg := TJPEGImage.Create;
  try
    jpeg.CompressionQuality := 100; {Default Value}
    jpeg.LoadFromFile(FileName);
    bmp := TBitmap.Create;
    try
      bmp.Assign(jpeg);
      IF SaveToFile Then Begin
        // save
        bmp.SaveTofile(FileFullPatch);
      End;
    finally
      bmp.Free;
    end; // try
  finally
    jpeg.Free;
  end; // try
  Result := FileFullPatch;
 End; // function JPEGsavetoBMP();

// ������� ��� ����������� jpg 2 bmp
// ���������
//  JPEG - �������� ��������
// ������������ ��������:
//  TBitmap
 function iJPEGtoBMP(var JPEG: TJPEGImage): TBitmap;
 Begin
   Result := TBitmap.Create;
   try
    Result.Assign(jpeg);
   except
    Result := nil;
   end;
 End; // function iJPEGtoBMP();


////////////////////////////////////////////////////////////
// ������
//

//////////////////////////////////////////////////////
// ��������� �������

// ������� ��������� ������ ���������� ������ �������� �
//���������� ��� � ��������� 'w*h'
//�������� ������ � BMP, JPG, PNG, GIF
//uses 'ImgSize.pas'
// ���������:
//  FileName      - TFileName ���� � �����
// ������������ ��������:
//  String
 function iGetSize(FileName: TFileName): Shortstring;
 Var FileExt: shortstring;
     QImg   : TQuickPixels;
     W, H   : Word;
 Begin
  FileExt := ExtractFileExt(FileName);
  if Uppercase(FileExt) = '.BMP' then begin
    QImg := TQuickPixels.Create;
    QImg.Attach(iOpenFromFile(FileName));
    W := QImg.Width;
    H := QImg.Height;
  end
  else if Uppercase(FileExt) = '.JPG' then begin
    GetJPGSize(FileName, W, H);
  end
  else if Uppercase(FileExt) = '.PNG' then begin
    GetPNGSize(FileName, W, H);
  end
  else if Uppercase(FileExt) = '.GIF' then begin
    GetGIFSize(FileName, W, H);
  end
  else begin
    Result := '';
    Exit;
  end;
  Result := IntToStr(W) + '*' + IntToStr(H);
 End; // GetImgSize();

// ������� ��������� ������ ���������� ������ ��������
//�������� ������ � BMP, JPG, PNG, GIF
//uses 'ImgSize.pas'
// ���������:
//  FileName      - TFileName ���� � �����
//  W,H           - ���������� �����
 procedure iGetSize(FileName: TFileName; out W, H: Word);
 Var FileExt: shortstring;
     QImg   : TQuickPixels;
 Begin
  FileExt := ExtractFileExt(FileName);
  if Uppercase(FileExt) = '.BMP' then begin
    QImg := TQuickPixels.Create;
    QImg.Attach(iOpenFromFile(FileName));
    W := QImg.Width;
    H := QImg.Height;
  end
  else if Uppercase(FileExt) = '.JPG' then begin
    GetJPGSize(FileName, W, H);
  end
  else if Uppercase(FileExt) = '.PNG' then begin
    GetPNGSize(FileName, W, H);
  end
  else if Uppercase(FileExt) = '.GIF' then begin
    GetGIFSize(FileName, W, H);
  end
  else begin
    W := 0; H := 0;
    Exit;
  end;
 End; // GetImgSize();


//////////////////////////////////////////////////////
// ��������� �������

// ������� ��������� ������� �������
// ���������:
//  BMP         - ��������
//  newH, newW  - ����� ������
//  *ResizeType - ��� ��������������
//  *Monochrome - ����������� ��?
// ������������ ���������:
//  ��������������� ������
 function iResize(BMP: TBitMap; newH, newW: Cardinal; ResizeType: TResizeType = fBilinearSpline;
                  Monochrome: Boolean = False): TBitMap;
 Var RArr, GArr, BArr, RArrS, GArrS, BArrS: TDDouble2Array;
 Begin
  if Monochrome then begin
    iBMPtoArray(BMP, GArr);
    GArrS  := aResize(GArr, newH, newW, ResizeType);
    Result := iArrayToBMP(GArrS);
  end
  else begin
    iBMPtoArray(BMP, RArr, GArr, BArr);
    RArrS   := aResize(RArr, newH, newW, ResizeType);
    GArrS   := aResize(GArr, newH, newW, ResizeType);
    BArrS   := aResize(BArr, newH, newW, ResizeType);
    Result  := iArraysToBMP(RArrS, GArrS, BArrS);
  end;
 End; // iResize();

////////////////////////////////////////////////////////////
// ������ � ��������
//

// ������� ��� �������� ������� � ��������
// ���������:
//  Symbol     - Char.    �������������� ������
//  *Size      - Integer. ������
//  *FName     - String.  ��� �������
//  *FStyles   - TFontStyles. set of TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrikeOut);
// ������������ ��������:
//  TBitMap
 function iCreateBMPwithFontSymbol(Symbol: Char; Size: Integer = 12; FName: String = 'Tahoma';
                                  FStyles: TFontStyles = []): TBitMap;
 Begin
  // ������� ������
  Result              := TBitmap.Create;
  Result.PixelFormat  := pf8bit;
  Result.Width        := 4*Size; // ���������� *3, �� ������ ������ 4
  Result.Height       := 4*Size;
  with Result.Canvas do
   begin
    // ����� ���
    Brush.Color := clWhite;
    Pen.Color   := Brush.Color;
    Rectangle(0, 0, Result.Width, Result.Height);
    // ������
    Pen.Color   := clBlack;
    Font.Color  := clBlack;
    Font.Size   := Size;
    Font.Style  := FStyles;
    Font.Name   := FName;
    TextOut(10, 10, Symbol);
   end;
 End; // iCreateBMPwithFontSymbol();


////////////////////////////////////////////////////////////////
// ��������� � ������� �����������
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ����������� � ���
//

//////////////////////////////////////////////////////
// ����������� � ������(�) ��������

// ������� ��� ����������� BMP � ����������� TImageArray
// ������ ������� �������� ����� ������ QPixels
// ���������:
//   BMP - TBitMap.
// ������������ ��������:
//  TByteArr
 procedure iBMPtoArray(var BMP: TBitMap; out Result: TImageArray);
 var QImg    : TQuickPixels;
     Pixel   : TColor;
     i,j     : integer;
  // �������������� ����� � �����
 function TColorToGrey(RGBColor: TColor): Byte;
  begin
   Result := Round((0.30*GetRValue(RGBColor)) + (0.59*GetGValue(RGBColor)) +
     (0.11*GetBValue(RGBColor)));
  end; // TColorToGrey();

 Begin
  QImg := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Qimg.Free;
    Result := nil;
    Exit;
  end;
  aSetLength(Result, QImg.Height, QImg.Width);
  for i := 0 to QImg.Height - 1 do Begin
    for j := 0 to QImg.Width - 1 do Begin
      // �������� �������
      Pixel := QImg.Pixels[j,i];
      // ����������� ����� � ����������
      Result[i,j] := TColorToGrey(Pixel);
    End;
  End;
  QImg.Free;
 End; // iBMPtoArray();

// ��������� ��� ����������� BMP � 3 TImageArray �� ������� �����
// ������ ������� �������� ����� ������ QPixels
// ���������:
//  BMP - TBitMap.
//  @RArr, GArr, BArr - ������� �������� �� ������� �����
 procedure iBMPtoArray(var BMP: TBitMap; out RArr, GArr, BArr: TImageArray);
 var QImg    : TQuickPixels;
     Pixel   : TColor;
     i,j     : integer;
 Begin
  QImg := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Exit;
  end;
  aSetLength(RArr, QImg.Height, QImg.Width);
  aSetLength(GArr, QImg.Height, QImg.Width);
  aSetLength(BArr, QImg.Height, QImg.Width);
  for i := 0 to QImg.Height - 1 do
  Begin
    for j := 0 to QImg.Width - 1 do
    Begin
      // �������� �������
      Pixel     := QImg.Pixels[j,i];
      // ����������� �����
      RArr[i,j] := GetRValue(Pixel);
      GArr[i,j] := GetGValue(Pixel);
      BArr[i,j] := GetBValue(Pixel);
    End;
  End;
  QImg.Free;
 End; // iBMPtoArray();

// ������� ��� ����������� BMP � ����������� TDDouble2Array
// ������ ������� �������� ����� ������ QPixels
// ���������:
//   BMP - TBitMap.
// ������������ ��������:
//  TByteArr
 procedure iBMPtoArray(var BMP: TBitMap; out Result: TDDouble2Array);
 var QImg: TQuickPixels;
     i,j : integer;
  // �������������� ����� � �����
 function TColorToGrey(RGBColor: TColor): Double;
 begin
  Result := 0.30*GetRValue(RGBColor)+0.59*GetGValue(RGBColor)+0.11*GetBValue(RGBColor);
 end; // TColorToGrey();

 Begin
  QImg := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Result := nil;
    Exit;
  end;
  aSetLength(Result, QImg.Height, QImg.Width);
  for i := 0 to QImg.Height - 1 do
    for j := 0 to QImg.Width - 1 do
      Result[i,j] := TColorToGrey(QImg.Pixels[j,i]);
  QImg.Free;
 End; // iBMPtoArray();

// ��������� ��� ����������� BMP � 3 TDDouble2Array �� ������� �����
// ������ ������� �������� ����� ������ QPixels
// ���������:
//  BMP - TBitMap.
//  @RArr, GArr, BArr - ������� �������� �� ������� �����
 procedure iBMPtoArray(var BMP: TBitMap; out RArr, GArr, BArr: TDDouble2Array);
 var QImg    : TQuickPixels;
     Pixel   : TColor;
     i,j     : integer;
 Begin
  QImg := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Exit;
  end;
  aSetLength(RArr, QImg.Height, QImg.Width);
  aSetLength(GArr, QImg.Height, QImg.Width);
  aSetLength(BArr, QImg.Height, QImg.Width);
  for i := 0 to QImg.Height - 1 do Begin
    for j := 0 to QImg.Width - 1 do Begin
      // �������� �������
      Pixel     := QImg.Pixels[j,i];
      // ����������� �����
      RArr[i,j] := GetRValue(Pixel);
      GArr[i,j] := GetGValue(Pixel);
      BArr[i,j] := GetBValue(Pixel);
    End;
  End;
  QImg.Free;
 End; // iBMPtoArray();


////////////////////////////////////////////////////////////
// ����������� �� ����
//

//////////////////////////////////////////////////////
// ����������� �� �������

// ������� ��� ����������� TImageArray � BMP
// ������ ������� �������� ����� ������ QPixels
// ���������� 8 ������� BMP (pf8Bit)
// ���������:
//  Arr      - TImageArray ��� ��������������
// ������������ ��������:
//  TBitMap
 function iArrayToBMP(var Arr: TImageArray): TBitMap;
 var BMP     : TBitMap;
     QImg    : TQuickPixels;
     i,j     : integer;
 Begin
  BMP              := TBitMap.Create;;
  BMP.Height       := Length(Arr);
  BMP.Width        := Length(Arr[0]);
  BMP.PixelFormat  := pf8Bit;
  QImg             := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Result := nil;
    Exit;
  end;
  for i := 0 to QImg.Height - 1 do
    for j := 0 to QImg.Width - 1 do
      QImg.Pixels[j,i] := RGB(Arr[i,j], Arr[i,j], Arr[i,j]);
  Result := BMP;
  QImg.Free;
 End; // iArrayToBMP();

// ������� ��� ����������� TImageArray � BMP
// ������ ������� �������� ����� ������ QPixels
// ���������� 8 ������� BMP (pf8Bit)
// ���������:
//  Arr      - TImageArray ��� ��������������
// ������������ ��������:
//  TBitMap
 function iArrayToBMP(var Arr: TDDouble2Array): TBitMap;
 var BMP     : TBitMap;
     QImg    : TQuickPixels;
     i,j     : integer;
 // ���������� ���������� � �����
 function RoundToByte(Value: Double): Byte;
 begin
  if Value < 0 then Result := 0
  else if Value > MAXBYTE then Result := MAXBYTE
  else Result := Round(Value);
 end;

 Begin
  BMP              := TBitMap.Create;;
  BMP.Height       := Length(Arr);
  BMP.Width        := Length(Arr[0]);
  BMP.PixelFormat  := pf8Bit;
  QImg             := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Result := nil;
    Exit;
  end;
  for i := 0 to QImg.Height - 1 do
    for j := 0 to QImg.Width - 1 do
      QImg.Pixels[j,i] := RGB(RoundToByte(Arr[i,j]), RoundToByte(Arr[i,j]), RoundToByte(Arr[i,j]));
  Result := BMP;
  QImg.Free;
 End; // iArrayToBMP();

// ������� ��������������� ������ ����������� � BMP
// ������ ������� �������� ����� ������ QPixels
// ���������� 8 ������� BMP (pf8Bit)
// ���������:
//  Arr - ������ ��������
// ������������ ��������
//  TBitMap
 function iArrayToBMP(var Arr: TImagesArray): TBitMap;
 Var i,j,k        : Word;
     BMP          : TBitmap;
     Height, Width, addLength: smallint;
     ArrLength    : Word;
     QImg         : TQuickPixels;
 Begin
  // ���������� ������ �����������
  Height    := 0;
  Width     := 0;
  ArrLength := Length(Arr);
  for i := 0 to High(Arr) do begin
    if Height < Length(Arr[i]) then Height := Length(Arr[i]);
    if Width  < ArrLength*Length(Arr[i,0]) then Width := ArrLength*Length(Arr[i,0]);
  end;
  // ������� ������
  BMP              := TBitMap.Create;
  BMP.Height       := Height;
  BMP.Width        := Width;
  BMP.PixelFormat  := pf8Bit;
  QImg             := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Result := nil;
    Exit;
  end;
  // ���������
  for k := 0 to High(Arr) do begin
    addLength := k*Length(Arr[k,0]);
    for i := 0 to High(Arr[k]) do
      for j := 0 to High(Arr[k,i]) do
        QImg.Pixels[j+addLength,i] := RGB(Arr[k,i,j], Arr[k,i,j], Arr[k,i,j]);
  end;
  Result := BMP;
  QImg.Free;
 End; // iArrayToBMP();

// ������� ��������������� ������ �������� � BMP
// ������ ������� �������� ����� ������ QPixels
// ���������� 8 ������� BMP (pf8Bit)
// ���������:
//  Arr - ������ ��������
// ������������ ��������
//  TBitMap
 function iArrayToBMP(var Arr: TSymbolsArray): TBitMap;
 Var tmp: TImagesArray;
 Begin
  tmp    := aConvertToArray(Arr);
  Result := iArrayToBMP(tmp);
 End; // iArrayToBMP();

//////////////////////////////////////////////////////
// ����������� �� ��������

// ������� ��� ����������� 3�� TDDouble2Array � BMP
// ������ ������� �������� ����� ������ QPixels
// ���������� 24 ������� BMP (pf24Bit)
// ���������:
//  RArr, GArr, BArr - ������� ������� ����� ��� ��������������
// ������������ ��������:
//  TBitMap
 function iArraysToBMP(var RArr, GArr, BArr: TDDouble2Array): TBitMap;
 var BMP     : TBitMap;
     QImg    : TQuickPixels;
     i,j     : integer;
  // ����������
 function RoundToByte(Value: Double): Byte;
 begin
  if Value < 0 then Result := 0
  else if Value > MAXBYTE then Result := MAXBYTE
  else Result := Round(Value);
 end;

 Begin
  BMP              := TBitMap.Create;;
  BMP.Height       := Length(RArr);
  BMP.Width        := Length(RArr[0]);
  BMP.PixelFormat  := pf24Bit;
  QImg             := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Result := nil;
    Exit;
  end;
  for i := 0 to QImg.Height - 1 do
    for j := 0 to QImg.Width - 1 do
      QImg.Pixels[j,i] := RGB(RoundToByte(RArr[i,j]), RoundToByte(GArr[i,j]), RoundToByte(BArr[i,j]));
  Result := BMP;
  QImg.Free;
 End; // iArraysToBMP();

// ������� ��� ����������� 3�� TImageArray � BMP
// ������ ������� �������� ����� ������ QPixels
// ���������� 24 ������� BMP (pf24Bit)
// ���������:
//  RArr, GArr, BArr - ������� ������� ����� ��� ��������������
// ������������ ��������:
//  TBitMap
 function iArraysToBMP(var RArr, GArr, BArr: TImageArray): TBitMap;
 var BMP     : TBitMap;
     QImg    : TQuickPixels;
     i,j     : integer;
 Begin
  BMP              := TBitMap.Create;;
  BMP.Height       := Length(RArr);
  BMP.Width        := Length(RArr[0]);
  BMP.PixelFormat  := pf24Bit;
  QImg             := TQuickPixels.Create;
  try
    QImg.Attach(BMP);
  except
    Result := nil;
    Exit;
  end;
  for i := 0 to QImg.Height - 1 do
    for j := 0 to QImg.Width - 1 do
      QImg.Pixels[j,i] := RGB(RArr[i,j], GArr[i,j], BArr[i,j]);
  Result := BMP;
  QImg.Free;
 End; // iArraysToBMP();

end. // ImgLibImageExt
