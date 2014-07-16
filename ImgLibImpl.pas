{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{           Copyright (c) 2009, Simkin A.V.             }
{                                                       }
{*******************************************************}
{         Library Version 0.8.7 from 25.04.2009         }
{*******************************************************}
{           'Implementation' from 25.04.2009            }
{*******************************************************}
unit ImgLibImpl;
 { ������ ���������� �������� �������� � ������� ���������� }
interface {�������� ��������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  Windows, SysUtils, //Classes, Variants,       // ��������� ������
  Graphics,                                     // �������������� ������
  ImgLibTypes;                                  // ������ ���������� IMG LIB

  ////////////////////////////////////////////////////////////
  // �������������� ��������� � �������
  //
  //////////////////////////////////////////////////////
  // ��������� � ������� ������ � ��������� �������� (TImageArray)
  //// ����� ��������� � ������� ////
  // ���������, �����
  function CompareTImageArray(const Arr1, Arr2 : TImageArray; pThreshold: byte =1):
                              Double; stdcall;
  function FindLineArrayInTImageArray(Arr: TImageArray; ArrLine: TDByteArray; Threshold: byte = 1): Word; stdcall;
  // ������
  procedure CalculateCentreOfMassBWTImageArray(const Arr: TImageArray; Margin: TMargins; out Xc, Yc: Word); stdcall;

  //// ������ � ������������ ����������� ////
  // �������
  function CreateAverageTBrightnessArray(Arr: TImageArray): TBrightnessArray; stdcall;
  function CreateImageAverageBrightness(AverageBrightnessArr: TBrightnessArray): Byte; stdcall;
  function CreateAverageNpxTBrightnessArray(AverageBrightnessArr: TBrightnessArray; N: Byte): TBrightnessArray; stdcall;

  //// ��������� � ������� ���������� ////
  function CreateTLevelsArray(const Arr: TImageArray): TLevelsArray; stdcall;
  function FindTImageArrayBlackThreshold(const Arr: TImageArray;
                                         FilterType: TBWFilterType = fBlackMass): Byte; stdcall;
  procedure MonochromeToBWTImageArray(Arr: TImageArray; BlackThreshold: byte = 128); stdcall;

  //// ��������� � ������� ����������� ////
  // �������������� ���������
  function CreateLabelsTImageArray(const Arr: TImageArray; Threshold: byte = 255;
                                   Upper: boolean = false): TImageArray; stdcall;
  function CreateLabelsCountArray(LabelsArray: TImageArray): TDWordArray; stdcall;
  // �������� ���������
  function SegmentMainSymbolToSquareArray(const Arr: TImageArray; Threshold: Byte = 255): TImageArray; stdcall;
  function SegmentSymbolToSquareArray(const Arr: TImageArray; pThreshold: Byte = 255): TImageArray; stdcall;
  function SegmentNMainSymbolsFromBWTImageArray(const Arr: TImageArray; SymbolsNumber: Byte): TImagesArray; stdcall;

  //// ��������� � ������� ������������� ////
  // ������������� 
  function FindDelimiterLine(Arr: TImageArray; CountryIndex: TCountryIndex = RUS): Word; stdcall;
  // ������������� ��������
  procedure RecognizeSymbolsFromBWTImageArray(var ResultArr: TSymbolsArray; Arr: TImageArray;
                                              SymbolsArr: TSymbolsArray; NewLength: Word;
                                              CountryIndex: TCountryIndex = RUS); stdcall;
  function RecognizeRUSNumberFromBWTImageArray(Arr: TImageArray; SymbolsArr:
                                               TSymbolsArray; NewLength: Word):
                                               TSymbolsArray; stdcall;
  function RecognizeMainSegmentSymbolsNumberFromBWTImageArray(Arr: TImageArray;
                                                              SymbolsArr: TSymbolsArray;
                                                              RecognizeLength: Word;
                                                              CountryIndex: TCountryIndex = RUS):
                                                              TSymbolsArray; stdcall;
  // ����� ������
  function FindNumberRectangle(Arr: TImageArray; CountryIndex: TCountryIndex = RUS): TMargins; stdcall;

  //////////////////////////////////////////////////////
  // ��������� � ������� ������ � ��������� ����������� (TImagesArray)
  //// ����� ��������� � ������� ////
  // �����������
  function CreateTImagesArrayFromStr(Symbols: String; Size: Integer = 12;
                                     FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                     SymbolArrLength: Word = 32):
                                     TImagesArray; stdcall;

  //// ��������� � ������� ���������� ////
  procedure MonochromeToBWTImagesArray(var Arr: TImagesArray; BlackThreshold: byte = 128); stdcall;

  //// ��������� � ������� ������������� ////
  function FindAndCompareWithTImagesArray(Arr: TImageArray; ArrSymbols: TImagesArray;
                                          Threshold: byte = 1): TImageArray; stdcall;
  function FindMapForTImagesArray(Arr, ArrSymbols: TImagesArray; Threshold: byte = 1): TImagesArray; stdcall;

  //////////////////////////////////////////////////////
  // ��������� � ������� ������ � ��������� ������� ����������� (TSymbolsArray)
  //// ����� ��������� � ������� ////
  // �����������
  function CreateTSymbolsArrayFromStr(Symbols: String; Size: Integer = 12;
                                      FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                      SymbolArrLength: Word = 32; BW: boolean = True):
                                      TSymbolsArray; stdcall;
  // �������������� � �������
  procedure ResizeTSymbolsArray(var Arr: TSymbolsArray; NewLength: Word; BW: boolean = True;
                                ResizeType: TResizeType = fBilinearSpline); stdcall;

  //// ��������� � ������� ���������� ////
  procedure MonochromeToBWTSymbolsArray(var Arr: TSymbolsArray; BlackThreshold: byte = 128); stdcall;

  //// ��������� � ������� �������������
  function FindAndCompareWithTSymbolsArray(Arr: TImageArray; ArrSymbols: TSymbolsArray;
                                           Threshold: byte = 1): TSymbol;stdcall;
  function FindMapForTSymbolsArray(Arr: TImagesArray; ArrSymbols: TSymbolsArray;
                                   Threshold: byte = 1): TSymbolsArray; stdcall;

  //////////////////////////////////////////////////////
  // ��������� � ������� ������ � ��������� ������� ����������� (TSizeSymbolsArray)
  //// ����� ��������� � ������� ////
  // �����������
  function CreateTSizeSymbolsArrayFromStr(Symbols: String; Size: Word = 72;
                                          FName: String = 'RoadNumbers'; FStyles: TFontStyles = [];
                                          BW: Boolean = True): TSizeSymbolsArray; stdcall;

implementation {���������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  //Classes,                            // ��������� ������
  Math,                                 // �������������� ������
  ImgLibArrayExt, ImgLibImageExt;       // ������ ���������� IMG LIB

////////////////////////////////////////////////////////////////////////////////
//// ��������� ��������� � �������
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//// �������������� ��������� � �������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
// ��������� � ������� ������ � ��������� �������� (TImageArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ����� ��������� � �������
//

//////////////////////////////////////////////////////
// ���������, �����

// ������� ���������� 2 ������� ����������� �������
//� ���������� ��������� ���������
//�������� � ������ �����
// ���������:
//  Arr1, Arr2  - TImageArray. �������� ������
//  pThreshold - Byte. ������� "��������" �.�. ������� ����� �����
//���������� (���������), ������� ��������� �����������
// ������������ ��������:
//  Double
 function CompareTImageArray(const Arr1, Arr2: TImageArray; pThreshold: byte = 1): Double;
 var i,j : word;
     AgreePixels: Cardinal;
 Begin
  // ��������
  if (Length(Arr1)<>Length(Arr2))or(Length(Arr1[0])<>Length(Arr2[0])) then
  begin
    Result := 0;
    Exit;
  end;
  // ���������
  AgreePixels := 0;
  for i := 0 to High(Arr1) do
  begin
    for j := 0 to High(Arr1[i]) do
    begin
      if Abs(Arr1[i,j] - Arr2[i,j]) < pThreshold then Inc(AgreePixels);
    end;
  end;
  Result := AgreePixels/Length(Arr1)/Length(Arr1[0]);
 End;

// ������� ���������� ��������� ������� �
//������� �������� �����������, ����������
// ������ �������� max ��������� ��������
//���� ��������� cAgreeLineHits ����� 0
// ���������:
//  Arr
//  ArrLine
//  *Threshold
// ������������ ��������:
//  Word
 function FindLineArrayInTImageArray(Arr: TImageArray; ArrLine: TDByteArray; Threshold: byte = 1): Word;
 const cAgreeLineHits = 0.60;
 var i,j        : Word;
     AgreePixels: Cardinal;
     AgreeArr   : TDDoubleArray;
 Begin
  Result := 0;
  SetLength(AgreeArr, Length(ArrLine));
  // ��������
  if Length(Arr)<>Length(ArrLine) then Exit;
  for j := 0 to High(Arr[0]) do
  begin
    // ���������
    AgreePixels := 0;
    for i := 0 to High(Arr) do
      if Abs(Arr[i,j] - ArrLine[i]) <= Threshold then Inc(AgreePixels);
    AgreeArr[j] := AgreePixels/Length(ArrLine);
  end;
  if cAgreeLineHits > AgreeArr[aIndexOfMaxValue(AgreeArr)] then Result := 0
  else Result := aIndexOfMaxValue(AgreeArr);
 End; // FindLineArrayInTImageArray();

//////////////////////////////////////////////////////
// ������

// ��������� ���������� ������ ���� ������ ��������������� �������
//(�������� ����������� ����!)
// ���������:
//  Arr - �������������� ������
//  Margin - ������� �������
//  @ Xc, Yc - �������� ��������
 procedure CalculateCentreOfMassBWTImageArray(const Arr: TImageArray; Margin: TMargins; out Xc, Yc: Word);
 var i,j          : Word;
     locMass      : Byte;
     SumX, SumY, N: Cardinal;
 Begin
  N := 0; SumX := 0; SumY := 0;
  for i := Margin.top to Margin.buttom do
   for j := Margin.left to Margin.right do begin
     locMass := Arr[i,j];
     Inc(SumX, (j - Margin.left)*locMass);
     Inc(SumY, (i - Margin.top)*locMass);
     Inc(N, locMass);
   end;
  Xc := Margin.left + round(SumX/N);
  Yc := Margin.top + round(SumY/N);
 End; // CalculateCentreOfMassBWTImageArray();


////////////////////////////////////////////////////////////
// ������ � ������������ �����������
//

//////////////////////////////////////////////////////
// �������

// ������� ������� ������ ������� �������
//������� �����������
// ���������:
//  Arr - ������ �������� �����������
// ������������ ��������:
//  TBrightnessArray
 function CreateAverageTBrightnessArray(Arr: TImageArray): TBrightnessArray;
 Var Height, Width, i, j: Word;
     SummBrightness     : Cardinal;
 Begin
  Height := Length(Arr);
  Width  := Length(Arr[0]);
  SetLength(Result, Width);
  for j := 0 to Width - 1 do
  begin
    SummBrightness := 0;
    for i := 0 to Height - 1 do Inc(SummBrightness, Arr[i,j]);
    Result[j] := ifthen(SummBrightness = 0, 0, Round(SummBrightness/Height));
  end;
 End; // CreateAverageTBrightnessArray();

// ������� ��������� ��������� ������� ������� �����������
// ���������:
//  AverageBrightnessArr - ������ ������� ��������
//������� �����������
// ������������ ��������:
//  Byte
 function CreateImageAverageBrightness(AverageBrightnessArr: TBrightnessArray): Byte;
 Var Count: Cardinal;
     i    : Word;
 Begin
   Count := 0;
   for i := 0 to High(AverageBrightnessArr) do Inc(Count, AverageBrightnessArr[i]);
   Result := ifthen(Count = 0, 0, Round(Count/Length(AverageBrightnessArr)));
 End; // CreateImageAverageBrightness();

// ������� ��������� (���������������) 
//������ ������������� �������� 
//����������� �� ������� ��������� N 
//��������
// ���������:
//  AverageBrightnessArr - ������ ������������� ��������
//  N - ���������� ����������� �������� (����������� �� ������ div)
// ������������ ��������:
//  TBrightnessArray
 function CreateAverageNpxTBrightnessArray(AverageBrightnessArr: TBrightnessArray; N: Byte): TBrightnessArray;
 var i, Step, count: word;
     j: Smallint;
     AverSumm: Cardinal;
 Begin
  SetLength(Result, Length(AverageBrightnessArr));
  for i := 0 to High(AverageBrightnessArr) do
  begin
    AverSumm := 0;
    Step     := N div 2;
    count    := 0;
    for j := i - Step to i + Step do
    begin
      if (j < 0) or (j > High(AverageBrightnessArr)) then Continue;
      Inc(AverSumm, AverageBrightnessArr[j]);
      Inc(count);
    end;
    Result[i] := round(AverSumm/count);
  end;
 End; // CreateAverageNpxTBrightnessArray();


////////////////////////////////////////////////////////////
// ��������� � ������� ����������
//

// ������� ������� ������ �������������
//�������� ������� �������� �����������
// ���������:
//  Arr - TImageArray. ������ ��� ���������� �������������
// ������������ ��������:
//  TLevelsArray
 function CreateTLevelsArray(const Arr: TImageArray): TLevelsArray;
 var i,j: integer;
 Begin
  fillchar(Result, Length(Result)*sizeof(Cardinal), 0);
  for i := 0 to High(Arr) do
  begin
    for j := 0 to High(Arr[i]) do
    begin
      Inc(Result[Arr[i,j]]);
    end;
  end;
 End; // CreateTLevelsArray();

// ������� ������� ������� ������� ����� � ������� ��������
//�� ������� mBlackMass (����� % ���������� �����
//������ ��������
//  ���������:
//   Arr        - TImageArray.
// ������������ ��������:
//  Byte
 function FindBlackThresholdFTypeBlackMass(Arr: TImageArray): Byte;
 const PercentMass  = 0.25; // *100% ������������ "�����" �����������
 var i                  : integer;
     maxMass, summMass  : Cardinal;
     LevelsArray        : TLevelsArray;
 Begin
  Result := 0;
  // �������� �������������
  LevelsArray := CreateTLevelsArray(Arr);
  // ���������� ������������ ����� �������������
  maxMass := 0;
  for i := 0 to High(LevelsArray) do Inc(maxMass, LevelsArray[i]);
  maxMass := Round(maxMass*PercentMass);
  // ���� ������� �������������
  summMass := 0;
  for i := 0 to High(LevelsArray) do
  begin
    Inc(summMass, LevelsArray[i]);
    if summMass >= maxMass then
    begin
      Result := i;
      Break;
    end;
  end;
 End; // FindBlackThresholdFTypeBlackMass();

// ������� ������� ������� ������� ����� � ������� ��������
//�� ������� mBlackMass (����� % ���������� ����� ������ ��������)
//  ���������:
//   Arr        - TImageArray.
// ������������ ��������:
//  Byte
 function FindBlackThresholdFTypeFindMin(Arr: TImageArray; PrioritySplineType: TSplineType = fAkima): Byte;
 var i, r                         : Integer;
     ReduceArray, LocalsMinReduce : TDCardinalArray;
     DiscPoints                   : TDByteArray;
     LocalsMinApr, LocalsMaxApr   : TDByteArray;
     LevelsArray, LevelsAproxArr  : TLevelsArray;
     DiscPointsLength             : Word;
     XArr, YArr, SplineCoeff      : TDDoubleArray;
     RArr                         : TDDoubleArray;
     imax1, imax2, igmax, k       : Byte;
     newpoint                     : Double;
 // ������� �������
 procedure FolgingArr();
 var i    : Word;
     first: Boolean;
 begin
  first := True;
  SetLength(ReduceArray, 0);
  SetLength(DiscPoints, 0);
  for i := 0 to High(LevelsArray) do begin
    if LevelsArray[i] <> 0 then begin
      if i = 0 then begin
        first := false;
      end
      else if (first) and (i <> 0) then begin
        aAddToArray(ReduceArray, LevelsArray[i]);
        aAddToArray(DiscPoints, 0);
        first := false;
      end;
      aAddToArray(ReduceArray, LevelsArray[i]);
      aAddToArray(DiscPoints, i);
    end;
  end;
  if DiscPoints[High(DiscPoints)] <> MAXBYTE then begin
    // ���� ��������� �� �������, ���������
    aAddToArray(ReduceArray, ReduceArray[High(DiscPoints)]);
    aAddToArray(DiscPoints, MAXBYTE);
  end;
 end;
 // ����� ���� ���������� ��������� ���������� � �������
 procedure FindTwoMainLocalMax(out i1, i2: byte);
 var PosPointArr : TPointPosArray;
     Point       : TPointPosition;
     i, HighA    : Word;
 begin
  // ����� ���� ������������ ����
  for i := 0 to High(LocalsMaxApr) do begin
    Point.i := LocalsMaxApr[i];
    Point.j := LevelsAproxArr[LocalsMaxApr[i]];
    aAddToArray(PosPointArr, Point);
  end;
  aBubbleSort(PosPointArr, 'j');
  HighA := High(PosPointArr);
  if PosPointArr[HighA - 1].i < PosPointArr[HighA].i then begin
    i1 := PosPointArr[HighA - 1].i;
    i2 := PosPointArr[HighA].i;
  end
  else begin
    i1 := PosPointArr[HighA].i;
    i2 := PosPointArr[HighA - 1].i;
  end;
 end; // FindTwoMainLocalMax();

 Begin
  //Result := 0;
  //// ��������������� ��������� ////
  // �������� �������������
  LevelsArray := CreateTLevelsArray(Arr);
  // ����������� ������
  FolgingArr();
  DiscPointsLength := Length(ReduceArray);
  // ���������� �������� �� ������� ��������� ���������
  LocalsMinReduce := aFindLocalsMin(ReduceArray);
  if Length(LocalsMinReduce) = 1 then begin
    if (LocalsMinReduce[0] = 0)or(LocalsMinReduce[0] + 1 = DiscPointsLength)
      then begin // ������� ��������� ��������
        igmax := aIndexOfMaxValue(LevelsArray);
        i     := LocalsMinReduce[0];
        Result := min(igmax, i) + round(Abs(igmax - i)/2);
        //Result := MAXBYTE div 2;
        Exit;
      end
    else begin
      Result := LocalsMinReduce[0];
      Exit;
    end;
  end;
  //// ������������ ////
  // ������������� ������
  SetLength(XArr, DiscPointsLength);
  SetLength(YArr, DiscPointsLength);
  for i := 0 to DiscPointsLength - 1 do begin
    XArr[i] := DiscPoints[i];
    YArr[i] := ReduceArray[i];
  end;
  aBuildSpline(XArr, YArr, SplineCoeff, PrioritySplineType);
  // ������������
  SetLength(RArr, MAXBYTE);
  for i := 0 to High(LevelsAproxArr) do begin
    newpoint := i;
    RArr[i] := aSplineInterpolation(SplineCoeff, newpoint);
  end;
  // smoothing
  aSmoothing(RArr, 5, fSevenNonLinear, 1.0, True);
  //SevenPointNonLinearSmoothing(RArr, 5, 5);
  for i := 0 to High(LevelsAproxArr) do begin
    LevelsAproxArr[i] := Round(RArr[i]);
  end;
  // max, min
  LocalsMaxApr := aFindLocalsMax(LevelsAproxArr);
  LocalsMinApr := aFindLocalsMin(LevelsAproxArr);
  FindTwoMainLocalMax(imax1, imax2);
  igmax := ifthen(LevelsAproxArr[imax1] >= LevelsAproxArr[imax2], imax1, imax2);
  if igmax = imax2 then begin //<= MAXBYTE div 2 then begin
    // left
    for k := imax2 downto imax1 do begin
      // ����� ���������� ��������
      if aFindInArray(LocalsMinApr, k, r, mBinary, False) then Break;
    end;
    Result := ifthen(LocalsMinApr[r] > imax2, LocalsMinApr[r-1], LocalsMinApr[r]);
  end
  else begin
    // right
    for k := imax1 to imax2 do begin
      // ����� ���������� ��������
      if aFindInArray(LocalsMinApr, k, r, mBinary, False) then Break;
    end;
    Result := ifthen(LocalsMinApr[r] < imax1, LocalsMinApr[r+1], LocalsMinApr[r]);
  end;
 End;// FindBlackThresholdFTypeFindMin();

// ������� ������� ������� ������� ����� � ������� ��������
// �������� � ����������� �� ���� �������
//  ���������:
//   Arr        - TImageArray.
//   *FilterType - TBWFilterType.
// ������������ ��������:
//  Byte
 function FindTImageArrayBlackThreshold(const Arr: TImageArray;
                                        FilterType: TBWFilterType = fBlackMass): Byte;
 const MaxThreshold = 185; // ������������ ������� ������ �� ������� �� ������������� ���������
       MinThreshold = 70;  // ����������� �������
 Begin
  Result := 0;
  case FilterType of
    fBlackMass: Result := FindBlackThresholdFTypeBlackMass(Arr);
    fFindMin  : Result := FindBlackThresholdFTypeFindMin(Arr);
  end;
  // �������� �������
  if MaxThreshold <= Result then Result := MaxThreshold
  else if MinThreshold > Result then Result := MinThreshold;
 End; // FindTImageArrayBlackThreshold();

// ��������� ����������� �� ������� �������� � �������
//������������ ������ � �������� ��� � ����������� ������ ��
//������ � ����� ������
// ���������:
//  Arr - TImageArray
//  BlackThreshold - Byte. ������� �� ������� ����
//��������� ������
 procedure MonochromeToBWTImageArray(Arr: TImageArray; BlackThreshold: byte = 128);
 Var i,j : integer;
 Begin
  for i := 0 to High(Arr) do
  begin
    for j := 0 to High(Arr[i]) do
    begin
      Arr[i,j] := ifthen(Arr[i,j] <= BlackThreshold, 0, 255);
    end;
  end;
 End; // MonochromeToBWTImageArray();


////////////////////////////////////////////////////////////
// ��������� � ������� �����������
//

//////////////////////////////////////////////////////
// �������������� ���������

// ������� ������� ������� �� ������������� ��������
//�� ������� ����� � ������� �����
// ���������:
//  LabelsArray - ������ �����
//  LabelIndex  - ������ �����
// ������������ ��������:
//  TMargins - ��������� �������
 function DetectMargins(LabelsArray: TImageArray; LabelIndex: word): TMargins;
 var i, j: Word;
 Begin
   // ������ �������, ���������� ������
   with Result do
   begin
    right  := 0;
    buttom := 0;
    left   := Length(LabelsArray[0]);
    top    := Length(LabelsArray);
   end;
   for i := 0 to High(LabelsArray) do
   begin
     for j := 0 to High(LabelsArray[i]) do
     Begin
       if LabelsArray[i,j] = LabelIndex then
       begin
         with Result do
         begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
         end;
       end;
     End;
   end;
 End; // DetectMargins();

// ������� "��������" ��� ������� � ������ 
//TPointPosArray, �.�. ������ ������ ��������� 
//�������� ���������� �������
// ���������:
//  LabelsArr  - ������ �����
//  Margin     - ������ ������
//  LabelIndex - �������������� ������
// ������������ ��������:
//  TPointPosArray
 function SegmentMarginsPoint(LabelsArr: TImageArray; Margin: TMargins; LabelIndex: Word): TPointPosArray;
 Var i,j      : Word;
     PointPos : TPointPosition;
 Begin
  SetLength(Result, 0);
  for i := Margin.left to Margin.right do
   for j := Margin.top to Margin.buttom do begin
     if LabelsArr[i,j] = LabelIndex then begin
       PointPos.i := i;
       PointPos.j := j;
       aAddToArray(Result, PointPos);
     end;
   end;
 End; // SegmentMarginsPoint();

// ������� ������� ������ ������/�����/�������
//������������ �������� �� ������� ��������
// ���������:
//  Arr - TImageArray. ������ ��� ����������
//  *Threshold - Byte. �������� ������
//  *Upper - Boolean. ������� ����� ��� ����
// ������������ ��������:
//  TImageArray - ��� �������� ��� ����� �������
 function CreateLabelsTImageArray(const Arr: TImageArray; Threshold: byte = 255; Upper: boolean = false): TImageArray;
 Type TPoint       = TPointPosition;
      TLabelsArray = TPointPosArray;
 Var i, j, outind           : integer;
     L, ArrHeight, ArrWidth : Word;
     Point                  : TPoint;
     LabelsArray, TmpLabels : TLabelsArray;
 // ������� ���������� ����� ��������
 function FindConnect(m,n: integer): Boolean;
 var i,j: Integer;
 begin
   for i := m - 1 to m + 1 do
   begin
     for j := n - 1 to n + 1 do
     begin
      if (i<0)or(i>=ArrHeight)or(j<0)or(j>ArrWidth)or((i=m)and(j=n)) then Continue
      else
      begin
        if ((Upper)and(Arr[i,j] > Threshold))or((not Upper)and(Arr[i,j] < Threshold)) then
        begin
          Result := True;
          Exit;
        end;
      end;
     end;
   end;
   Result := False;
 end; // FindConnect();
 // ������� ���������� ��������� �������� � ������
 function AddCoonected(m,n: integer): TLabelsArray;
 var i,j  : integer;
     Point: TPoint;
 begin
   SetLength(Result, 0);
   for i := m - 1 to m + 1 do
   begin
     for j := n - 1 to n + 1 do
     begin
      if (i<0)or(i>=ArrHeight)or(j<0)or(j>ArrWidth)or((i=m)and(j=n)) then Continue
      else begin
        if ((Upper)and(Arr[i,j] > Threshold)) or ((not Upper)and(Arr[i,j] < Threshold))
        then begin
          Point.i := i;
          Point.j := j;
          aAddToArray(Result, Point);
        end
        else Continue;
      end;
     end;
   end;
 end;
 // ������� ���������� ��������� �������� � ������ � ����������� ��� ���
 function AddCoonectedExcept(m,n: integer): TLabelsArray;
 var i, j, tmp  : integer;
     Point      : TPoint;
 begin
   SetLength(Result, 0);
   for i := m - 1 to m + 1 do
   begin
     for j := n - 1 to n + 1 do
     begin
      if (i<0)or(i>=ArrHeight)or(j<0)or(j>ArrWidth)or((i=m)and(j=n)) then Continue
      else
      begin
        if ((Upper)and(Arr[i,j] > Threshold))or((not Upper)and(Arr[i,j] < Threshold)) then
        begin
          Point.i := i;
          Point.j := j;
          if aFindInArray(LabelsArray, Point, tmp) then Continue;
          aAddToArray(Result, Point);
        end
        else Continue;
      end;
     end;
   end;
 end;
 // ��������� ��� ���������� ��������� ����� �� ��������
 procedure SetFromParent(var ArrResult: TImageArray; TmpLabels: TLabelsArray);
 var i,j          : integer;
     Point        : TPoint;
     NewTmpLabels : TLabelsArray;
 begin
  for Point in TmpLabels do
  begin
    i               := Point.i;
    j               := Point.j;
    ArrResult[i,j]  := L;
    // ���� �����
    if not FindConnect(i, j) then Continue;
    NewTmpLabels    := AddCoonectedExcept(i, j);
    if Length(NewTmpLabels) = 0 then Continue;
    aAddFromArray(LabelsArray, NewTmpLabels);
    // �������� ����������
    SetFromParent(ArrResult, NewTmpLabels);
  end;
 end;

 Begin
  ArrHeight := Length(Arr);
  ArrWidth  := Length(Arr[0]);
  L := 0;
  aSetLength(Result, ArrHeight, ArrWidth);
  for i := 0 to High(Arr) do begin
    for j := 0 to High(Arr[i]) do begin
      if Arr[i,j] < Threshold then begin
        // ����� �����
        Point.i := i;
        Point.j := j;
        if aFindInArray(LabelsArray, Point, outind) then Continue;
        // ����� �������
        Inc(L);
        aAddToArray(LabelsArray, Point);
        Result[i,j] := L;
        // ����� ���������
        if not FindConnect(i, j) then Continue;
        SetLength(TmpLabels, 0);
        TmpLabels := AddCoonected(i, j);
        if Length(TmpLabels) = 0 then Continue;
        // ���������
        aAddFromArray(LabelsArray, TmpLabels);
        SetFromParent(Result, TmpLabels);
      end;
    end;
  end;
 End; // CreateLabelsTImageArray();

// �������� ������� "�����" �������� �����
// ���������:
//   LabelsArray - ������ ����� ��������� ��������
// ������������ ��������:
//  TDWordArray - ������, ��� ������ - ����� �����,
//�������� - ���������� ����� � �������
 function CreateLabelsCountArray(LabelsArray: TImageArray): TDWordArray;
 Var i, j, L, maxL: Word;
 Begin
  maxL := 0;
  SetLength(Result, maxL + 1);
  for i := 0 to High(LabelsArray) do
  begin
    for j := 0 to High(LabelsArray[i]) do
    begin
      L := LabelsArray[i,j];
      if maxL < L then
      begin
        maxL := L;
        SetLength(Result, maxL + 1);
      end;
      if L = 0 then Continue;
      Inc(Result[L]);
    end;
  end;
 End; // CreateLabelsCountArray();

//////////////////////////////////////////////////////
// �������� ���������

// ������� �� �������� ������� ��������
//������ �������� ������ �� �������, �������� ��� � ����������� �
//�������� � ����� ������
// ���������:
//  Arr          - TImageArray. �������� ������
//  *pThreshold  - Byte. ��������� �������� �������
// ������������ ��������:
//  TImageArray
 function SegmentMainSymbolToSquareArray(const Arr: TImageArray; Threshold: Byte = 255): TImageArray;
 Var LabelsArray  : TImageArray;
     LabelCountArr: TDWordArray;
     LabelIndex   : Cardinal;
 // ��������� ������� � ���������� ������
 procedure SegmentSymbolToSquareArray();
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // ������ �������, ���������� ������
    //����� �� ���������� ��������
    ArrHeigth := length(LabelsArray);
    ArrWidth  := length(LabelsArray[0]);
    right     := 0;
    buttom    := 0;
    left      := ArrWidth;
    top       := ArrHeigth;
    for i := 0 to High(LabelsArray) do
    begin
      for j := 0 to High(LabelsArray[i]) do
      Begin
        if LabelsArray[i,j] = LabelIndex then
        begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
        end;
      End;
    end;
    // ��������� ���������� ������
    // �������� �������� �����, ����� ����� 
    //������� ���� ������
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // ������ ����������
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0)or(j<0)or(j>=ArrWidth)or(i>=ArrHeigth) then Result[i - top, j - left] := 255
            else if LabelsArray[i,j] = LabelIndex then Result[i - top, j - left] := Arr[i,j]
            else Result[i - top, j - left] := 255;
          end;
      end;
  end; // SegmentSymbolToSquareArray();

 Begin
  // ����������� � �����
  LabelsArray   := CreateLabelsTImageArray(Arr, Threshold);
  // ������� ����� ������� ��������� �������
  LabelCountArr := CreateLabelsCountArray(LabelsArray);
  LabelIndex    := aIndexOfMaxValue(LabelCountArr);
  // ������� ���������� ������
  SegmentSymbolToSquareArray();
 End; // SegmentMainSymbolToSquareArray();

// ������� �� �������� ������� ��������
//������ �� �������, �������� ��� � ����������� �
//�������� � ����� ������
// ���������:
//  Arr          - TImageArray. �������� ������
//  *pThreshold  - Byte. ��������� �������� �������
// ������������ ��������:
//  TImageArray
 function SegmentSymbolToSquareArray(const Arr: TImageArray; pThreshold: Byte = 255): TImageArray;
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // ������ �������, ���������� ������
    //����� �� ���������� ��������
    ArrHeigth := length(Arr);
    ArrWidth  := length(Arr[0]);
    right     := 0;
    buttom    := 0;
    left      := ArrWidth;
    top       := ArrHeigth;
    for i := 0 to High(Arr) do
    begin
      for j := 0 to High(Arr[i]) do
      Begin
        if Arr[i,j] < pThreshold then
        begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
        end;
      End;
    end;
    // ��������� ���������� ������
    // �������� �������� �����, ����� ����� 
    //������� ���� ������
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // ������ ����������
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0) or (j<0) or (j>=ArrWidth) or (i>=ArrHeigth) then Result[i - top, j - left] := 255
            else Result[i - top, j - left] := Arr[i,j];
          end;
      end;
  end; // SegmentSymbolToSquareArray();

// ������� � TImagesArray �������� ������ N �����
//������� �������� �� TImageArray
// ���������:
//  Arr           - TImageArray;
//  SymbolsNumber - Byte.
// ������������ ��������:
//  TImagesArray
 function SegmentNMainSymbolsFromBWTImageArray(const Arr: TImageArray; SymbolsNumber: Byte): TImagesArray;
 Type TIncCountArr   = array[0..1] of Word;
      TLabelCountArr = array of TIncCountArr;
 Var LabelsArray  : TImageArray;
     LabelCountArr: TLabelCountArr;
     i            : Byte;
     LabelIndex   : Word;
     TmpArr       : TImageArray;
 // �������� ������� "�����" �����
 function CreateLabelCountArr(): TLabelCountArr;
 var i,j          : integer;
     L, maxL      : Word;
 begin
  maxL := 0;
  SetLength(Result, maxL + 1);
  for i := 0 to High(LabelsArray) do
  begin
    for j := 0 to High(LabelsArray[i]) do
    begin
      L := LabelsArray[i,j];
      if maxL < L then
      begin
        maxL := L;
        SetLength(Result, maxL + 1);
      end;
      if L = 0 then Continue;
      Inc(Result[L,0]);
      Result[L,1] := L;
    end;
  end;
 end; // CreateLabelCountArr();
// ���������� ���������
 procedure BubbleSort(var data: TLabelCountArr);
 var i,j: word;
     P: TIncCountArr;
 begin
 for i := 0 to High(data) do
  for j := 0 to High(data)-i do
  if data[j,0] < data[j+1,0] then
    begin
     P        := data[j];
     data[j]  := data[j+1];
     data[j+1]:= P;
    end;
 end; // BubbleSort();
 // ��������� ������� � ���������� ������
 function SegmentSymbolToSquareArray(LabelIndex: Word): TImageArray;
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // ������ �������, ���������� ������
    //����� �� ���������� ��������
    ArrHeigth := length(LabelsArray);
    ArrWidth  := length(LabelsArray[0]);
    right     := 0;
    buttom    := 0;
    left      := ArrWidth;
    top       := ArrHeigth;
    for i := 0 to High(LabelsArray) do
    begin
      for j := 0 to High(LabelsArray[i]) do
      Begin
        if LabelsArray[i,j] = LabelIndex then
        begin
          if j > right  then right  := j;
          if i > buttom then buttom := i;
          if j < left   then left   := j;
          if i < top    then top    := i;
        end;
      End;
    end;
    // ��������� ���������� ������
    // �������� �������� �����, ����� ����� 
    //������� ���� ������
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // ������ ����������
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0)or(j<0)or(j>=ArrWidth)or(i>=ArrHeigth) then Result[i - top, j - left] := 255
            else if LabelsArray[i,j] = LabelIndex then Result[i - top, j - left] := Arr[i,j]
            else Result[i - top, j - left] := 255;
          end;
      end;
  end; // SegmentSymbolToSquareArray();
 // ���������� ������ ������� � ������
 procedure AddToTImagesArray(var SymbolsArr: TImagesArray; Arr: TImageArray);
 var newLength: Word;
 begin
  newLength := High(SymbolsArr) + 1;
  SetLength(SymbolsArr, newLength + 1);
  aSetLength(SymbolsArr[newLength], Length(Arr), Length(Arr[0]));
  SymbolsArr[newLength] := Arr;
 end;

 Begin
  // ����������� � �����
  LabelsArray   := CreateLabelsTImageArray(Arr);
  // ������� ������������� "�����" ��������
  LabelCountArr := CreateLabelCountArr();
  // ���������
  BubbleSort(LabelCountArr);
  // �������� ������ N ��������
  for i := 0 to SymbolsNumber - 1 do
  begin
    LabelIndex  := LabelCountArr[i,1];
    TmpArr      := SegmentSymbolToSquareArray(LabelIndex);
    aAddToArray(Result, TmpArr);
  end;
 End; // SegmentNMainSymbols();


////////////////////////////////////////////////////////////
// ��������� � ������� �������������
//

//////////////////////////////////////////////////////
// �������������

// ������� ������ ������� �����������
//�.�. ������� ������� �������� � TImageArray
//���������� �������� ������� ���������� ���������� �����������
// ���������:
//  Arr
// ������������ ��������:
//  Word
 function FindDelimiterLine(Arr: TImageArray; CountryIndex: TCountryIndex = RUS): Word;
 const cCoeffMinBright = 0.10;
 var AverageBrightnessArr, Average3pxBrightnessArr : TBrightnessArray;
     minBright, ImageAverageBrightness, MaxBright  : Byte;
     i, iminBright, LineW, imin, imax              : Word;
     ArrLine                                       : TDByteArray;
     LocalMins                                     : TDWordArray;
 Begin
  // ����� ������� �� ���������� ��������� //
  SetLength(ArrLine, Length(Arr));
  // �������� �������� ��������
  AverageBrightnessArr   := CreateAverageTBrightnessArray(Arr);
  ImageAverageBrightness := CreateImageAverageBrightness(AverageBrightnessArr);
  //// �������� �������
  // ����� �������� ��� ���. ����
  minBright  := MAXBYTE;
  iminBright := 0;
  for i := 0 to High(AverageBrightnessArr) do
  begin
    // ���� ���������� ����
    if AverageBrightnessArr[i] = 0 then begin
      Result := i;
      Exit;
    end;
    // ���� �������
    if minBright > AverageBrightnessArr[i] then begin
      iminBright := i;
      minBright  := AverageBrightnessArr[i];
    end;
  end;
  // ���� ������ � ������� �������, ��� �����
  if minBright < cCoeffMinBright*MAXBYTE then begin
    Result := iminBright;
    Exit;
  end;
  //// ������� ������� ����
  // ����� ��������� ��������
  LocalMins := aFindLocalsMin(AverageBrightnessArr);
  // ������� ������� 3 �������� ��������
  Average3pxBrightnessArr := CreateAverageNpxTBrightnessArray(AverageBrightnessArr, 3);
  LineW     := Round(CountrySettings[CountryIndex].cfLineW*Length(Arr));
  MaxBright := Round(CountrySettings[CountryIndex].cfMaxBright*MAXBYTE);
  for i := 0 to High(LocalMins) do begin
    imin := ifthen(LocalMins[i]-LineW < 0, 0, LocalMins[i]-LineW);
    imax := ifthen(LocalMins[i]+LineW > High(AverageBrightnessArr), High(AverageBrightnessArr), LocalMins[i]+LineW);
    if (AverageBrightnessArr[imax]>MaxBright)
    and (AverageBrightnessArr[imin]>MaxBright)
    and (Average3pxBrightnessArr[imin]>ImageAverageBrightness)
    and (Average3pxBrightnessArr[imax]>ImageAverageBrightness) then
    begin
      Result := LocalMins[i];
      Exit;
    end;
  end;
  Result := 0;
 End; // FindDelimiterLine();

//////////////////////////////////////////////////////
// ������������� ��������

// ��������� ������������� ������� �
//������� ������� ��������
// ���������� ��������� �������������
// ���������:
//  ResultArr - ������ ����������
//  Arr - �������������� ������
//  SymbolsArr - ������  ������� ��������
//  NewLength - ����� ������ �������
 procedure RecognizeSymbolsFromBWTImageArray(var ResultArr: TSymbolsArray; Arr: TImageArray;
                                             SymbolsArr: TSymbolsArray; NewLength: Word;
                                             CountryIndex: TCountryIndex = RUS); stdcall;
 const cCoeffRightFindArea = 0.15;
       cCoeffPercentRight  = 0.05;
       cCoeffBeginStep     = 0.70;
 var AverageBrightnessArr                     : TBrightnessArray;
     i, di, di2, i0, ik, inew, iLocMax        : Word;
     FirstFlag, SecondFlag, ThirdFlag         : boolean;
     NSymbols, LocBrigth                      : byte;
     LocalMaxArr                              : TDWordArray;
     ImgArr                                   : TImageArray;
     Symbol                                   : TSymbol;
     ImageAverageBrightness                   : Byte;
     Height, Width                            : Word;
 // ��������� �������� ������ ������������ ���������� ���������
 function CheckBoarders(): Boolean;
 Var LeftFlag, RightFlag                            : Boolean;
     i, AverMinus, SymbSpace                        : word;
     RightConfirmPXb, RightConfirmPXa, ConfirmPXNeed: byte;
 begin
  LeftFlag      := False;
  RightFlag     := False;
  SymbSpace     := Round(CountrySettings[CountryIndex].cfSymbolSpace*Height);
  ConfirmPXNeed := Round(cCoeffPercentRight*Height);
  // left (check in 2 left px) //
  if LocBrigth > AverageBrightnessArr[ifthen(iLocMax - 2 < 0, 0, iLocMax - 2)]
    then LeftFlag := True;
  // check size
  if iLocMax + 1 > High(AverageBrightnessArr) then begin
    if LeftFlag then Result := True
    else Result := False;
    Exit;
  end;
  // right //
  RightConfirmPXa := 0;
  RightConfirmPXb := 0;
  for i := iLocMax to iLocMax + SymbSpace do
  begin
    if i > High(AverageBrightnessArr) then begin
     if (RightConfirmPXa>0)or(RightConfirmPXa>0) then RightFlag := True;
     break;
    end;
    AverMinus := Round(AverageBrightnessArr[i] - AverageBrightnessArr[i]*cCoeffPercentRight);
    if  (AverMinus <= LocBrigth)
    and (AverageBrightnessArr[i] >= MAXBYTE*CountrySettings[CountryIndex].cfMaxBright)
      then begin
       Inc(RightConfirmPXa);
      end;
    if (AverageBrightnessArr[i-1] < AverageBrightnessArr[i])
    and (AverageBrightnessArr[i] > MAXBYTE*CountrySettings[CountryIndex].cfMaxBright)
      then begin
       Inc(RightConfirmPXb);
      end;
    if (RightConfirmPXa >= ConfirmPXNeed)or(RightConfirmPXb >= ConfirmPXNeed)
    then begin
      RightFlag := True;
      Break;
    end;
  end;
  Result := (LeftFlag)and(RightFlag);
 end; // CheckBoarders();
 // ���������� ������ ���������� �������
 function FindNextBoarder(): Word;
 var k, AverMinus: word;
 begin
  k := i0;
  AverMinus := Round(LocBrigth - LocBrigth*cCoeffPercentRight);
  repeat
    if (AverMinus > AverageBrightnessArr[k])
    and (AverageBrightnessArr[k] < MAXBYTE*CountrySettings[CountryIndex].cfMaxBright) then Break;
    Inc(k);
  until (k >= ik)or(k >= Width);
  Result := k;
 end; // FindNextBoarder();

 Begin
  //// �������� �������� ��������
  AverageBrightnessArr   := CreateAverageTBrightnessArray(Arr);
  ImageAverageBrightness := CreateImageAverageBrightness(AverageBrightnessArr);
  // ��������� �������
  Height := Length(Arr);
  Width  := Length(Arr[0]);
  //// ����� � ��������� �������� � �����������
  // ��������� �������
  di        := Round(Height*CountrySettings[CountryIndex].cfSymbolWidth);
  i0        := 0;
  di2       := Round(di/2);
  ik        := di + di2; // � ������ ����� ����������� ��������
  NSymbols  := 0;
  // ���� �� ~ ����������
  repeat
    // ����� �������������� ������ ����
    LocalMaxArr := aFindLocalsMax(AverageBrightnessArr, i0, ik);
    if Length(LocalMaxArr) = 0 then Break;
    LocBrigth   := 0;
    inew        := 0;
    // ������� (���������� ���������� �������)
    for i := 0 to High(LocalMaxArr) do
    begin
      // nulled
      FirstFlag   := False;
      SecondFlag  := False;
      ThirdFlag   := False;
      // new local max
      iLocMax   := LocalMaxArr[i];
      LocBrigth := AverageBrightnessArr[iLocMax];
      // 1.
      if (i0 + round(di2*cCoeffBeginStep) <= iLocMax)and(iLocMax <= ik) then FirstFlag := True;
      // 2.
      if CheckBoarders() then SecondFlag := True;
      // 3.
      if (ImageAverageBrightness <= LocBrigth)and(LocBrigth>=MAXBYTE*CountrySettings[CountryIndex].cfMaxBright)
        then ThirdFlag := True;
      // ��������
      if FirstFlag and SecondFlag and ThirdFlag then
      begin
        inew := iLocMax;
        Break;
      end;
    end;
    if inew = 0 then Break;
    //// �������������
    // ���������
    ImgArr := SegmentMainSymbolToSquareArray(aCrop(Arr, 0, ifthen(inew - di < 0, 0, inew - di),
                                                             High(Arr), inew + round(cCoeffRightFindArea*di)));
    // ��������� �������, BW
    ImgArr := aResize(ImgArr, NewLength, NewLength);
    MonochromeToBWTImageArray(ImgArr, FindTImageArrayBlackThreshold(ImgArr));
    // �������������
    Symbol := FindAndCompareWithTSymbolsArray(ImgArr, SymbolsArr);
    if Symbol.hit < cAgreeHits then Exit;
    //// ����������
    aAddToArray(ResultArr, Symbol);
    Inc(NSymbols);
    //// ����������� ����� �������
    // ��������������
    i0 := inew + 1;
    ik := i0 + di;
    // ���� "������"
    i0 := FindNextBoarder();
    ik := i0 + di;
  until (NSymbols >= CountrySettings[CountryIndex].MaxSymbols)or(i0 > Width - di2);
 end; // RecognizeSymbolsFrommBWTImageArray();

// ������� ������������� �����������
//�������������� ������
// ���������:
//  Arr - �������� �����������
//  SymbolsArr - ������ ��������
//  NewLength - ������ ������ �������
// ������������ ��������
//  TImagesArray
 function RecognizeRUSNumberFromBWTImageArray(Arr: TImageArray; SymbolsArr: TSymbolsArray; NewLength: Word): TSymbolsArray;
 Var SeriesWidthMax, SeriesWidthMin, SeriesBorder : Word;
     Height, RegionHeight, tmpLength              : Word;
     Symbol                                       : TSymbol;
 Begin
  // ��������� �������
  Height := Length(Arr);
  // ����� "�����������" ��������
  SeriesWidthMax := Round(CountrySettings[RUS].cfSeriesMax*Height);
  SeriesWidthMin := Round(CountrySettings[RUS].cfSeriesMin*Height);
  SeriesBorder   := FindDelimiterLine(aCrop(Arr, 0, SeriesWidthMin, High(Arr), SeriesWidthMax));
  if SeriesBorder <> 0 then begin
    SeriesBorder := SeriesWidthMin + SeriesBorder;
    // ���������� �������
    // 1. ������� "����� + ��������"
    RecognizeSymbolsFromBWTImageArray(Result, aCrop(Arr, 0, 0, High(Arr), SeriesBorder), SymbolsArr, NewLength);
    aSetLength(Symbol.img, 32, 32);
    Symbol.symbol := '?';
    while Length(Result) < CountrySettings[RUS].MinSeriesSymbols do
      aAddToArray(Result, Symbol);
    // space
    Symbol.symbol := ' ';
    aAddToArray(Result, Symbol);
    tmpLength := Length(Result);
    // 2. ������� "������"
    RegionHeight := Round(CountrySettings[RUS].cfRegionH*Height);
    RecognizeSymbolsFromBWTImageArray(Result, aCrop(Arr, 0, SeriesBorder + 1, RegionHeight, High(Arr[0])), SymbolsArr, NewLength);
    Symbol.symbol := '?';
    while Length(Result) - tmpLength < CountrySettings[RUS].MinRegionSymbols do
      aAddToArray(Result, Symbol);
  end
  else begin
    // ������� ���� �� ����������, ����������
    //����� ������
  end;
 End; // RecognizeNumberSymbolsFromBWTImageArray();

// ������� � TImagesArray �������� ������ N �����
//������� �������� �� TImageArray
// ���������:
//  Arr           - TImageArray;
//  SymbolsNumber - Byte.
// ������������ ��������:
//  TImagesArray
 function RecognizeMainSegmentSymbolsNumberFromBWTImageArray(Arr: TImageArray; SymbolsArr: TSymbolsArray;
                                                             RecognizeLength: Word;
                                                             CountryIndex: TCountryIndex = RUS): TSymbolsArray;
 Const cCoeffPxMargin = 0.1; // ��������� ������ ������ ������ ������
 Var LabelsArray, ImgArr          : TImageArray;
     LabelCount                   : TDWordArray;
     SymbolH, SymbolW, px, i      : Word;
     MaxLabelsMass, MinLabelsMass : Word;
     Symbol                       : TSymbol;
     SymbMargins                  : TMargins;
     Xc, Yc                       : Word;
 // ��������� ������� � ���������� ������
 function SegmentSymbolToSquareArray(LabelIndex: Word; out Margins: TMargins): TImageArray;
  var right, buttom, left, top, i, j, addPoints, ArrHeigth, ArrWidth: smallint;
      Height, Width: Word;
  begin
    // ������ �������, ���������� ������
    Margins := DetectMargins(LabelsArray, LabelIndex);
    left    := Margins.left;
    right   := Margins.right;
    buttom  := Margins.buttom;
    top     := Margins.top;
    // ��������� ���������� ������
    // �������� �������� �����, ����� �����
    //������� ���� ������
    top    := top    + (buttom - top) mod 2 - 1;
    left   := left   + (right - left) mod 2 - 1;
    Height := buttom - top;
    Width  := right - left;
    if Height > Width then
      begin
        addPoints := (Height - Width) div 2;
        left      := left - addPoints;
        right     := right + addPoints;
        Width     := Height;
      end
    else if Height < Width then
      begin
        addPoints := (Width - Height) div 2;
        buttom    := buttom + addPoints;
        top       := top - addPoints;
        Height    := Width;
      end;
    // ������ ����������
    ArrHeigth := length(LabelsArray);
    ArrWidth  := length(LabelsArray[0]);
    aSetLength(Result, Height + 1, Width + 1);
    for i := top to buttom do
      begin
        for j := left to right do
          begin
            if (i<0)or(j<0)or(j>=ArrWidth)or(i>=ArrHeigth) then Result[i - top, j - left] := 255
            else if LabelsArray[i,j] = LabelIndex then Result[i - top, j - left] := Arr[i,j]
            else Result[i - top, j - left] := 255;
          end;
      end;
  end; // SegmentSymbolToSquareArray();

 Begin
  SetLength(Result, 0);
  // ����������� � �����
  LabelsArray := CreateLabelsTImageArray(Arr);
  // ������� ������������� "�����" ��������
  LabelCount  := CreateLabelsCountArray(LabelsArray);
  // �����������
  SymbolH       := Round(Length(Arr)*CountrySettings[RUS].cfSymbolHeight);
  SymbolW       := Round(Length(Arr)*CountrySettings[RUS].cfSymbolWidth);
  MaxLabelsMass := SymbolH*SymbolW;
  MinLabelsMass := SymbolH;
  px            := Round(cCoeffPxMargin*Length(Arr));
  // ������������� ���������� �����
  for i := 0 to High(LabelCount) do begin
    if (MinLabelsMass < LabelCount[i]) and (LabelCount[i] < MaxLabelsMass) then begin
      ImgArr := SegmentSymbolToSquareArray(i, SymbMargins);
      // �������� ������
      if (SymbMargins.right <= px) or (SymbMargins.left >= High(LabelsArray[0])-px)
      or (SymbMargins.buttom <= px) or (SymbMargins.top >= High(LabelsArray)-px)
        then Continue;
      // ��������� �������, BW
      ImgArr := aResize(ImgArr, RecognizeLength, RecognizeLength);
      MonochromeToBWTImageArray(ImgArr, FindTImageArrayBlackThreshold(ImgArr));
      // �������������
      Symbol := FindAndCompareWithTSymbolsArray(ImgArr, SymbolsArr);
      if Symbol.hit < cAgreeHits then Continue;
      CalculateCentreOfMassBWTImageArray(ImgArr, SymbMargins, Xc, Yc);
      Symbol.position := Xc;//SymbMargins.left;
      // ����������
      aAddToArray(Result, Symbol);
    end;
    if CountrySettings[CountryIndex].MaxSymbols <= Length(Result) then Break;
  end; // for i := 0 to High(LabelCount) do begin
  aBubbleSort(Result);
 End; // SegmentNMainSymbols();

//////////////////////////////////////////////////////
// ����� ������

// !not final
// ������� ������ ������ �� ���� �������
//��������
// ���������:
//  Arr           -
//  *CountryIndex - ���. ������
 function FindNumberRectangle(Arr: TImageArray; CountryIndex: TCountryIndex = RUS): TMargins;
 Var i, j, H, W    : Word;
    // DiffArr: TImageArray;
   //  PointArr         : TPointParArray;
     Point2Arr        : TPointPar2Array;
     ImgArr, LabelsArr: TImageArray;
     LabelCountArr    : TDWordArray;
     Margin           : TMargins;
    // PointsPosArr     : TPointPosArray;
   //  PointsPos2Arr    : TPointPos2Array;
 Begin
  // ������
  aSetLength(Point2Arr, Length(Arr) - 1, Length(Arr[0]) - 1);
  // 1. ������������
  for i := 0 to High(Point2Arr) do begin
    for j := 0 to High(Point2Arr[i]) do begin
      Point2Arr[i,j].gx := Arr[i+1,j+1] - Arr[i,j];
      Point2Arr[j,i].gy := Arr[j+1,i+1] - Arr[j,i];
    end;
  end;
  aSetLength(ImgArr, Length(Point2Arr), Length(Point2Arr[0]));
  for i := 0 to High(Point2Arr) do begin
    for j := 0 to High(Point2Arr[i]) do begin
      with Point2Arr[i,j] do
      begin
        p  := abs(gx) + abs(gy);
        fi := ArcTan2(gy, gx);
      end;
      ImgArr[i,j] := Point2Arr[i,j].p;
    end;
  end;
  // 2. �����
  LabelsArr     := CreateLabelsTImageArray(ImgArr, 100, True);
  LabelCountArr := CreateLabelsCountArray(LabelsArr);
  for i := 0 to High(LabelCountArr) do begin
    Margin := DetectMargins(LabelsArr, i);
    W := Abs(Margin.right - Margin.left);
    H := Abs(Margin.top - Margin.buttom);
    if  (CountrySettings[CountryIndex].cfMinRectangle < W/H)
    and (W/H < CountrySettings[CountryIndex].cfMaxRectangle)
    then begin
      // segment
      SegmentMarginsPoint(LabelsArr, Margin, i);
    end;
  end;

 End; // FindNumberRectangle();



////////////////////////////////////////////////////////////////
// ��������� � ������� ������ � ��������� ����������� (TImagesArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ����� ��������� � �������
//

//////////////////////////////////////////////////////
// �����������

// ������� ������� ������ ��������� ��
//������� �������� ������� �� ������������ 
//�������� � ������
// ���������:
//  Symbol     - Char.    �������������� ������
//  *Size      - Integer. ������
//  *FName     - String.  ��� �������
//  *FStyles   - TFontStyles. set of TFontStyle = (fsBold, fsItalic,
//fsUnderline, fsStrikeOut);
//  *SymbolArrLength  - Word. ����� ������� �������
//�������
// ������������ ��������:
//  TImagesArray
 function CreateTImagesArrayFromStr(Symbols: String; Size: Integer = 12;
                                     FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                     SymbolArrLength: Word = 32): TImagesArray;
 Var i, StrLength : Integer;
     Arr, origArr : TImageArray;
     BMPSymbol    : TBitmap;
 Begin
  StrLength := Length(Symbols);
  aSetLength(Result, StrLength, SymbolArrLength, SymbolArrLength);
  for i := 1 to StrLength do
  begin
    BMPSymbol   := iCreateBMPwithFontSymbol(Symbols[i], Size, FName, FStyles);
    iBMPtoArray(BMPSymbol, origArr);
    origArr     := SegmentSymbolToSquareArray(origArr);
    Arr         := aResize(origArr, SymbolArrLength, SymbolArrLength);
    Result[i-1] := Arr;
  end;
 End; // CreateTImagesArrayFromStr();


////////////////////////////////////////////////////////////
// ��������� � ������� ����������
//

// ��������� �� ������� �������� � �������
//������������ ������ � �������� ��� � ����������� ������ ��
//������ � ����� ������
// ���������:
//  Arr - TImagesArray
//  BlackThreshold - Byte. ������� �� ������� ���� 
//��������� ������
 procedure MonochromeToBWTImagesArray(var Arr: TImagesArray; BlackThreshold: byte = 128);
 Var k: integer;
 Begin
  for k := 0 to High(Arr) do
  begin
    MonochromeToBWTImageArray(Arr[k], BlackThreshold);
  end;
 End; // MonochromeToBWTImagesArray();


////////////////////////////////////////////////////////////
// ��������� � ������� �������������
//

// ������� ���������� ������ �������� 
//TImageArray � �������� �������� TImageArray � 
//������� �������� ��������������� ������
// ���������:
//  Arr        - ������ ��������
//  ArrSymbols - ������ �������� ��� ������
//  *Threshold - Byte. ������� "��������" �.�. ������� ����� �����
//���������� (���������), ������� ��������� 
//�����������
// ������������ ��������:
//  TImageArray
 function FindAndCompareWithTImagesArray(Arr: TImageArray; ArrSymbols: TImagesArray; Threshold: byte = 1): TImageArray;
 Var  i, imax   : word;
      ArrResult : TDDoubleArray;
      maxRes    : Double;
 Begin
  // ��������� ������� �����������
  SetLength(ArrResult, Length(ArrSymbols));
  for i := 0 to High(ArrSymbols) do
  begin
    ArrResult[i] := CompareTImageArray(Arr, ArrSymbols[i], Threshold);
  end;
  // ��������� ���������� �����������
  maxRes := MinDouble;
  imax   := 0;
  for i := 0 to High(ArrResult) do
  begin
    if ArrResult[i] > maxRes then
    begin
      maxRes := ArrResult[i];
      imax   := i;
    end;
  end;
  Result := ArrSymbols[imax];
 End; // FindAndCompareWithTImagesArray();

// ������� ������ ����������� ��� ������� 
//�������� Arr �� ������� �������� ArrSymbols
//���������� ������ � ����������� ��� Arr
// ���������:
//  Arr1, Arr2  - TImagesArray. �������� ������ � ������
//��� ������ (������ �������������� ������� 
//�������� �������� ��������)
//  *Threshold - Byte. ������� "��������" �.�. ������� ����� �����
//���������� (���������), ������� ��������� �����������
// ������������ ��������:
//  TImagesArray
 function FindMapForTImagesArray(Arr, ArrSymbols: TImagesArray; Threshold: byte = 1): TImagesArray;
 var i          : word;
     FindSymbol : TImageArray;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]), Length(Arr[0,0]));
  for i := 0 to High(Arr) do
  begin
    FindSymbol := FindAndCompareWithTImagesArray(Arr[i], ArrSymbols, Threshold);
    Result[i]  := FindSymbol;
  end;
 End; // FindMapForTImagesArray();



////////////////////////////////////////////////////////////////
// ��������� � ������� ������ � ��������� ������� ����������� (TSymbolsArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ����� ��������� � �������
//

//////////////////////////////////////////////////////
// �����������

// ������� ������� ������ ��������� ��
//������� �������� ������� �� ������������
//�������� � ������
// ���������:
//  Symbols    - String.  �������������� �������
//  *Size      - Integer. ������
//  *FName     - String.  ��� �������
//  *FStyles   - TFontStyles. set of TFontStyle = (fsBold, fsItalic,
//fsUnderline, fsStrikeOut);
//  *SymbolArrLength  - Word. ����� ������� �������
//  *BW        - boolean. ���������� ����������� �������
//�������
// ������������ ��������:
//  TSymbolsArray
 function CreateTSymbolsArrayFromStr(Symbols: String; Size: Integer = 12;
                                     FName: String = 'Tahoma'; FStyles: TFontStyles = [];
                                     SymbolArrLength: Word = 32; BW: boolean = True): TSymbolsArray;
 Var i, StrLength : Integer;
     Arr, origArr : TImageArray;
     BMPSymbol    : TBitmap;
     Rec          : TSymbol;
 Begin
  StrLength := Length(Symbols);
  aSetLength(Result, StrLength);
  for i := 1 to StrLength do
  begin
    BMPSymbol   := iCreateBMPwithFontSymbol(Symbols[i], Size, FName, FStyles);
    iBMPtoArray(BMPSymbol, origArr);
    origArr     := SegmentSymbolToSquareArray(origArr);
    Arr         := aResize(origArr, SymbolArrLength, SymbolArrLength);
    if BW then MonochromeToBWTImageArray(Arr, FindTImageArrayBlackThreshold(Arr));
    Rec.img     := Arr;
    Rec.symbol  := Symbols[i];
    Result[i-1] := Rec;
  end;
 End; // CreateTSymbolsArrayFromStr();

//////////////////////////////////////////////////////
// �������������� � �������

// ������� ����������� � ���������� ������� ���������� ������� ��� �������
//����������� �������� �������
// ������������� ������������, ������ ��� ���������� ������� �����������
// ���������:
//  Arr         - TSymbolsArray. �������� ������
//  NewLength   - Word. ������� ������� (���������� �����)
//  *BW         - Boolean. ������������ �� ������?
//  *ResizeType - ��� ��������������
 procedure ResizeTSymbolsArray(var Arr: TSymbolsArray; NewLength: Word; BW: boolean = True;
                               ResizeType: TResizeType = fBilinearSpline);
 var i        : word;
     ResizeArr: TImageArray;
 Begin
  for i := 0 to High(Arr) do
  begin
    ResizeArr   := aResize(Arr[i].img, NewLength, NewLength);
    if BW then MonochromeToBWTImageArray(ResizeArr, 
      FindTImageArrayBlackThreshold(ResizeArr));
    Arr[i].img := ResizeArr;
  end;
 End; // ResizeTSymbolsArray();


////////////////////////////////////////////////////////////
// ��������� � ������� ����������
//

// ��������� �� ������� �������� � �������
//������������ ������ � �������� ��� � ����������� ������ ��
//������ � ����� ������
// ���������:
//  Arr - TImagesArray
//  BlackThreshold - Byte. ������� �� ������� ���� 
//��������� ������
 procedure MonochromeToBWTSymbolsArray(var Arr: TSymbolsArray; BlackThreshold: byte = 128);
 Var k: integer;
 Begin
  for k := 0 to High(Arr) do
  begin
    MonochromeToBWTImageArray(Arr[k].img, BlackThreshold);
  end;
 End; // MonochromeToBWTSymbolsArray();


////////////////////////////////////////////////////////////
// ��������� � ������� �������������
//

// ������� ���������� ������ ��������
//TImageArray � �������� �������� TImageArray � 
//������� �������� ��������������� ������
// ���������:
//  Arr        - ������ ��������
//  ArrSymbols - ������ �������� ��� ������
//  *Threshold - Byte. ������� "��������" �.�. ������� ����� �����
//���������� (���������), ������� ��������� 
//�����������
// ������������ ��������:
//  TSymbol
 function FindAndCompareWithTSymbolsArray(Arr: TImageArray; ArrSymbols: TSymbolsArray; Threshold: byte = 1): TSymbol;
 type DoubleArr = array of double;
 Var  i, imax   : word;
      ArrResult : DoubleArr;
      maxRes    : Double;
 Begin
  // ��������� ������� �����������
  SetLength(ArrResult, Length(ArrSymbols));
  for i := 0 to High(ArrSymbols) do
  begin
    ArrResult[i] := CompareTImageArray(Arr, ArrSymbols[i].img, Threshold);
  end;
  // ��������� ���������� �����������
  maxRes := MinDouble;
  imax   := 0;
  for i := 0 to High(ArrResult) do
  begin
    if ArrResult[i] > maxRes then
    begin
      maxRes := ArrResult[i];
      imax   := i;
    end;
  end;
  Result     := ArrSymbols[imax];
  Result.hit := maxRes;
 End; // FindAndCompareWithTSymbolsArray();

// ������� ������ ����������� ��� �������
//�������� Arr �� ������� �������� ArrSymbols 
//���������� ������ � ����������� ��� Arr
// ���������:
//  Arr1, Arr2  - TImagesArray. �������� ������ � ������
//��� ������ (������ �������������� ������� 
//�������� �������� ��������)
//  *Threshold - Byte. ������� "��������" �.�. ������� ����� �����
//���������� (���������), ������� ��������� �����������
// ������������ ��������:
//  TImagesArray
 function FindMapForTSymbolsArray(Arr: TImagesArray; ArrSymbols: TSymbolsArray; Threshold: byte = 1): TSymbolsArray;
 var i          : word;
     FindSymbol : TSymbol;
 Begin
  aSetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do
  begin
    FindSymbol := FindAndCompareWithTSymbolsArray(Arr[i], ArrSymbols, Threshold);
    Result[i]  := FindSymbol;
  end;
 End; // FindMapForTSymbolsArray();



////////////////////////////////////////////////////////////////
// ��������� � ������� ������ � ��������� ������� ����������� (TSizeSymbolsArray)
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ����� ��������� � �������
//

//////////////////////////////////////////////////////
// �����������

// ������� ������� ������ �� ������� �������� TSymbolsSize
//��������� �� TSymbols ������� �� ������������
//�������� � ������
// ���������:
//  Symbols    - String.  �������������� �������
//  *Size      - Integer. ������
//  *FName     - String.  ��� �������
//  *FStyles   - TFontStyles. set of TFontStyle = (fsBold, fsItalic, fsUnderline, fsStrikeOut);
//  *BW        - boolean. ���������� ����������� �������
 function CreateTSizeSymbolsArrayFromStr(Symbols: String; Size: Word = 72;
                                          FName: String = 'RoadNumbers'; FStyles: TFontStyles = [];
                                          BW: Boolean = True):
                                          TSizeSymbolsArray;
 Var SizeSymbol   : TSymbolSize;
 Begin
  for SizeSymbol := Low(TSymbolSize) to High(TSymbolSize) do begin
    Result[SizeSymbol] := CreateTSymbolsArrayFromStr(Symbols, Size, FName, FStyles,
                                                     GetTSymbolSize(SizeSymbol), BW);
  end;
 End; // CreateTSymbolsArrayFromStr();

initialization {��������� ����������� ���� ��� ��� ������ ��������� � ������}

finalization {���������, ����������� ��� ����� ���������� ������ ������}

end. // ImgLib Unit

