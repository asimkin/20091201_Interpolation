{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{           Copyright (c) 2009, Simkin A.V.             }
{                                                       }
{*******************************************************}
{         Library Version 0.8.7 from 25.04.2009         }
{*******************************************************}
{        'Array Extension Works' from 25.04.2009        }
{*******************************************************}
unit ImgLibArrayExt;
 { ������ ������ � �������� ��������� ���������� }
interface {�������� ��������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  Windows,                              // ��������� ������
  ImgLibTypes;                          // ������ ���������� IMG LIB

  ////////////////////////////////////////////////////////////
  // �������� ��������� � ������� ������
  //
  //////////////////////////////////////////////////////
  // �������� ��������� � ������� ��������� ��������
  //// �������� � ���������� �������� ////
  // ��������� �������
  procedure aSetLength(var Arr: TImageArray; H, W: Word); overload; stdcall; //forward;
  procedure aSetLength(var Arr: TImagesArray; K, H, W: Word); overload; stdcall; //forward;
  procedure aSetLength(var Arr: TSymbolsArray; K: Word); overload; stdcall; //forward;
  procedure aSetLength(var Arr: TPointPar2Array; H, W: Word); overload; stdcall;// forward;
  procedure aSetLength(var Arr: TDDouble2Array; H, W: Word); overload; stdcall; //forward;
  // ���������� ������ ��������
  procedure aAddToArray(var Arr: TDByteArray; New: Word); overload; stdcall; //forward;
  procedure aAddToArray(var Arr: TDWordArray; New: Word); overload; stdcall; //forward;
  procedure aAddToArray(var Arr: TDCardinalArray; New: Cardinal); overload; stdcall; //forward;
  procedure aAddToArray(var Arr: TImagesArray; New: TImageArray); overload; stdcall; //forward;
  procedure aAddToArray(var Arr: TSymbolsArray; New: TSymbol); overload; stdcall; //forward;
  procedure aAddToArray(var Arr: TPointPosArray; New: TPointPosition); overload; stdcall; //forward;
  // ����������� ������������ ��������
  function aDynamicArrayCopy(const A: TDIntegerArray): TDIntegerArray; overload; stdcall;
  function aDynamicArrayCopy(const A: TDDoubleArray): TDDoubleArray; overload; stdcall;
  function aDynamicArrayCopy(const A: TDBooleanArray): TDBooleanArray; overload; stdcall;
  function aDynamicArrayCopy(const A: TDInteger2Array): TDInteger2Array; overload; stdcall;
  function aDynamicArrayCopy(const A: TDDouble2Array): TDDouble2Array; overload; stdcall;
  function aDynamicArrayCopy(const A: TDBoolean2Array): TDBoolean2Array; overload; stdcall;
  // �������� ����������
  function aCheckIncSort(var Arr: TDByteArray): Boolean; stdcall;
  function aCheckDecSort(var Arr: TDByteArray): Boolean; stdcall;
  // ����������
  procedure aBubbleSort(var data: TDWordArray); overload; stdcall;
  procedure aBubbleSort(var data: TSymbolsArray); overload; stdcall;
  procedure aBubbleSort(var data: TPointPosArray; SortRec: Char = 'i'); overload; stdcall;
  procedure aQuickSort(var data: TDByteArray); overload; stdcall;
  procedure aQuickSort(var data: TDWordArray); overload; stdcall;
  // ���������
  function aCrop(const Arr: TImageArray; i0, j0, ik, jk: Smallint; Relative: Boolean = False): TImageArray; stdcall;

  //// �������� ������ �������� ////
  // �������� �����
  function aLinearFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer): Boolean; overload; stdcall;
  function aLinearFind(Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean; overload; stdcall;
  // �������� �����
  function aBinaryFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer; Precision: Boolean = False): Boolean; stdcall;
  // ����� ��������
  function aFindInArray(var Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean; overload; stdcall;
  function aFindInArray(var Arr: TDByteArray; Value: Byte; out FindIndex: Integer; FindType: TFindType = mLinear; Precision: Boolean = False): Boolean; overload; stdcall;
  // ����� ������� ����������� ���������
  function aIndexOfMaxValue(const Arr: TDWordArray): Cardinal; overload; stdcall;
  function aIndexOfMaxValue(const Arr: TLevelsArray): Byte; overload; stdcall;
  function aIndexOfMaxValue(const Arr: TDDoubleArray): Word; overload; stdcall;
  // ����� ��������� ��������� � ����������
  function aFindLocalsMin(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray; overload; stdcall;
  function aFindLocalsMin(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMin(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray; overload; stdcall;
  function aFindLocalsMin(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray; overload; stdcall;
  function aFindLocalsMax(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray; overload; stdcall;

  //// ����������� �������� ������ � ��������� ////
  // ���������� ����� ��������
  procedure aAddFromArray(var Arr1: TPointPosArray; Arr2: TPointPosArray); stdcall;

  //// �������� ����������� ////
  // ����������� � ������ ������
  function aConvertToArray(var Arr: TImageArray): TDDouble2Array; overload; stdcall;
  function aConvertToArray(var Arr: TDDouble2Array): TImageArray; overload; stdcall;
  function aConvertToArray(var Arr: TSymbolsArray): TImagesArray; overload; stdcall;
  function aConvertToArray(var Arr: TImagesArray): TSymbolsArray; overload; stdcall;
  procedure aConvertToArray(var Arr: TImageArray; out Result: TDDouble2Array); overload; stdcall;
  // ����������� � ������
  function aConvertToString(var Arr: TImageArray; StepLeft: Shortstring = ' '; StepDown: Shortstring = #13#10): String; stdcall;

  //////////////////////////////////////////////////////
  // ��������� � ������� �������������� ���������
  //// ���������� ////
  // ���������� ������������� �������
  procedure aBuildSpline(var XArr, YArr: TDDoubleArray; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fCubic); overload; stdcall;
  procedure aBuildSpline(var XArr, YArr: TDDoubleArray; var FArr: TDDouble2Array; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fBicubic); overload; stdcall;
  // ���������� �������� ������� � �����
  function aSplineInterpolation(var SplineCoeff: TDDoubleArray; var Value: Double): Double; stdcall;
  function aSplineInterpolation2D(var SplineCoeff: TDDoubleArray; var ValueX, ValueY: Double): Double; stdcall;
  // ���������� ������ �� 7 ������
  procedure aSevenPointNonLinearSmoothing(var ValueArray: TDDoubleArray; Coef: integer); stdcall;
  // ���������� ������ ����������� ���������
  procedure aCubicSplineSmoothing(var ValueArray: TDDoubleArray; Dsc: double; Coef: integer); stdcall;
  // �����������
  procedure aSmoothing(var Arr: TDDoubleArray; Coef: Word; SmoothType: TSmoothingType = fCubicSpline;
                       Dsc: Double = 1.0; CycledFilter: Boolean = false); stdcall;
  // ���������� ��������������
  procedure aLinearTrendExclusion(var Arr: TDDoubleArray); stdcall;

  //// ������������ �������������� ////
  // �����
  procedure aFourierAnalysis(var ValueArray: TDDoubleArray; NumGarmonics: integer); stdcall;
  // ������� ��� ������
  function aCalculateAreaOfArray(var arr: TDDoubleArray; i0, ik: integer; Method: byte = 1; BindToZero: boolean = true): Double; stdcall;

  //// �������������� �����������/��������������� ////
  // ���������� ������
  procedure aIncreaseLength(var Arr: TDDoubleArray; SplitValue: integer); stdcall;
  // ���������� ������
  procedure aDecreaseLength(var Arr: TDDoubleArray; SplitValue: integer); stdcall;
  // ���������� �������
  function aExpandLength(var Arr: TDDoubleArray; ExpandCoef: integer): TDDoubleArray; stdcall;
  // ��������� ������� ������� AverageArea
  function aAverageAreaResize(var Arr: TImageArray; NewH, NewW: Word): TImageArray; overload; stdcall;
  function aAverageAreaResize(var Arr: TDDouble2Array; NewH, NewW: Cardinal): TDDouble2Array; overload; stdcall;
  // ��������� �������
  function aResize(var Arr: TDDouble2Array; newH, newW: Cardinal; ResizeType: TResizeType = fBilinearSpline): TDDouble2Array; overload; stdcall;
  function aResize(var Arr: TImageArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImageArray; overload; stdcall;
  function aResize(var Arr: TImagesArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImagesArray; overload; stdcall;

implementation {���������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  SysUtils,                             // ��������� ������
  Math,                                 // �������������� ������
  SplineLibLinear, SplineLibBilinear;   // ������� ������ ���������� ��������

////////////////////////////////////////////////////////////////////////////////
//// ��������� ��������� � ������� ������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// �������������� ���������� ��������
//

// ������� ����������� ���������� � �����
 function RoundToByte(Value: Double): Byte;
 Begin
  if Value < 0 then Result := 0
  else if Value > MAXBYTE then Result := MAXBYTE
  else Result := Round(Value);
 End; // RoundToByte();


 
////////////////////////////////////////////////////////////////////////////////
//// �������� ��������� � �������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// �������� � ���������� ��������
//

//////////////////////////////////////////////////////
// ��������� �������

// ��������� ������������ ����������� ������� TImageArray
 procedure aSetLength(var Arr: TImageArray; H, W: Word);
 var i: Word;
 begin
   SetLength(Arr, H);
   for i := 0 to High(Arr) do SetLength(Arr[i], W);
 end; // aSetLength();

// ��������� ������������� ����������� ������� TImagesArray
 procedure aSetLength(var Arr: TImagesArray; K, H, W: Word);
 var i: Word;
 begin
   SetLength(Arr, K);
   for i := 0 to High(Arr) do aSetLength(Arr[i], H, W);
 end; // aSetLength();

// ��������� ������������� ����������� ������� TSymbolsArray
 procedure aSetLength(var Arr: TSymbolsArray; K: Word);
 begin
   SetLength(Arr, K);
 end; // aSetLength();

// ��������� ������������� ����������� ������� TPointPar2Array
 procedure aSetLength(var Arr: TPointPar2Array; H, W: Word);
 var i: word;
 begin
   SetLength(Arr, H);
   for i := 0 to High(Arr) do SetLength(Arr[i], W);
 end; // aSetLength();

// ��������� ������������� ����������� ������� TDDouble2Array
 procedure aSetLength(var Arr: TDDouble2Array; H, W: Word);
 begin
   SetLength(Arr, H, W);
 end; // aSetLength();

//////////////////////////////////////////////////////
// ���������� ������ ��������

// ��������� ��������� ����� ������� � ������ TDWordArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TDByteArray; New: Word);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TDWordArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TDWordArray; New: Word);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TDCardinalArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TDCardinalArray; New: Cardinal);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TImagesArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TImagesArray; New: TImageArray);
 begin
  SetLength(Arr, Length(Arr) + 1);
  aSetLength(Arr[High(Arr)], Length(New), Length(New[0]));
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TSymbolsArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TSymbolsArray; New: TSymbol);
 begin
  aSetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TPointPosArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TPointPosArray; New: TPointPosition);
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

//////////////////////////////////////////////////////
// ����������� ������������ ��������

// ������� ����������� ������������� �������
 function aDynamicArrayCopy(const A: TDIntegerArray): TDIntegerArray;
 var I: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do
    Result[I]:=A[I];
 end; // aDynamicArrayCopy();

// ������� ����������� ������������� �������
 function aDynamicArrayCopy(const A: TDDoubleArray): TDDoubleArray;
 var I: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do
    Result[I]:=A[I];
 end; // aDynamicArrayCopy();

// ������� ����������� ������������� �������
 function aDynamicArrayCopy(const A: TDBooleanArray): TDBooleanArray;
 var I: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do
    Result[I]:=A[I];
 end; // aDynamicArrayCopy();

// ������� ����������� ������������� �������
 function aDynamicArrayCopy(const A: TDInteger2Array): TDInteger2Array;
 var I,J: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do begin
    SetLength(Result[I], High(A[I])+1);
    for J:=Low(A[I]) to High(A[I]) do
      Result[I,J]:=A[I,J];
  end;
 end; // aDynamicArrayCopy();

// ������� ����������� ������������� �������
 function aDynamicArrayCopy(const A: TDDouble2Array): TDDouble2Array;
 var I,J: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do begin
    SetLength(Result[I], High(A[I])+1);
    for J:=Low(A[I]) to High(A[I]) do
      Result[I,J]:=A[I,J];
  end;
 end; // aDynamicArrayCopy();

// ������� ����������� ������������� �������
 function aDynamicArrayCopy(const A: TDBoolean2Array): TDBoolean2Array;
 var I,J: Integer;
 begin
  SetLength(Result, High(A)+1);
  for I:=Low(A) to High(A) do begin
    SetLength(Result[I], High(A[I])+1);
    for J:=Low(A[I]) to High(A[I]) do
      Result[I,J]:=A[I,J];
  end;
 end; // aDynamicArrayCopy();

//////////////////////////////////////////////////////
// �������� ����������

 // �������� ����������� ������������ �������
 function aCheckIncSort(var Arr: TDByteArray): Boolean;
 Var i, h: integer;
 Begin
  i := 0;
  h := High(Arr) - 1;
  while (i < h) and (Arr[i] <= Arr[i+1]) do Inc(i);
  if (i = h) and (Arr[i] <= Arr[i+1]) then Result := True
  else Result := False;
 End; // aCheckIncSort();

 // �������� ����������� �������� �������
 function aCheckDecSort(var Arr: TDByteArray): Boolean;
 Var i, h: integer;
 Begin
  i := 0;
  h := High(Arr) - 1;
  while (i < h) and (Arr[i] >= Arr[i+1]) do Inc(i);
  if (i = h) and (Arr[i] >= Arr[i+1]) then Result := True
  else Result := False;
 End; // aCheckDecSort()

//////////////////////////////////////////////////////
// ����������

// ���������� ��������� � ������� TDWordArray
 procedure aBubbleSort(var data: TDWordArray);
 var i, j: Integer;
     tmp : Word;
 begin
 for i := 1 to High(data) do
  for j := 0 to High(data) - i do
    if data[j] < data[j+1] then begin
      tmp       := data[j];
      data[j]   := data[j+1];
      data[j+1] := tmp;
    end;
 end; // aBubbleSort();

// ���������� ��������� � ������� TSymbolsArray
 procedure aBubbleSort(var data: TSymbolsArray);
 var i, j: Integer;
     tmp : TSymbol;
 begin
 for i := 1 to High(data) do
  for j := 0 to High(data) - i do
    if data[j].position > data[j+1].position then begin
      tmp       := data[j];
      data[j]   := data[j+1];
      data[j+1] := tmp;
    end;
 end; // aBubbleSort();

// ���������� ��������� � ������� TPointPosArray
 procedure aBubbleSort(var data: TPointPosArray; SortRec: Char = 'i');
 var i, j: Integer;
     tmp : TPointPosition;
 begin
 case SortRec of
  'i': begin
         for i := 1 to High(data) do
          for j := 0 to High(data) - i do
            if data[j].i > data[j+1].i then
              begin
               tmp       := data[j];
               data[j]   := data[j+1];
               data[j+1] := tmp;
              end;
       end;
  'j': begin
         for i := 1 to High(data) do
          for j := 0 to High(data) - i do
            if data[j].j > data[j+1].j then
              begin
               tmp       := data[j];
               data[j]   := data[j+1];
               data[j+1] := tmp;
              end;
       end;
 end;
end; // aBubbleSort();

// ���������� ���������� QuickSort � ������� TDByteArray
 procedure aQuickSort(var data: TDByteArray);
 // ��������� ��������
 procedure QSort(var b: TDByteArray; iLo, iHi: Integer);
 var   Lo, Hi: Integer;
       Mid, t: Byte;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := b[(Lo + Hi) div 2];
   repeat
     while b[Lo] < Mid do Inc(Lo);
     while b[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then begin
       t     := b[Lo];
       b[Lo] := b[Hi];
       b[Hi] := t;
       Inc(Lo);
       Dec(Hi);
     end;
   until Lo > Hi;
   if Hi > iLo then QSort(b, iLo, Hi);
   if Lo < iHi then QSort(b, Lo, iHi);
 end; // QSort();

 begin
  QSort(data, Low(data), High(data));
 end; // aQuickSort();

// ���������� ���������� QuickSort � ������� TDWordArray
 procedure aQuickSort(var data: TDWordArray);
 // ��������� ��������
 procedure QSort(var b: TDWordArray; iLo, iHi: Integer);
 var   Lo, Hi: Integer;
       Mid, t: Word;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := b[(Lo + Hi) div 2];
   repeat
     while b[Lo] < Mid do Inc(Lo);
     while b[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then begin
       t     := b[Lo];
       b[Lo] := b[Hi];
       b[Hi] := t;
       Inc(Lo);
       Dec(Hi);
     end;
   until Lo > Hi;
   if Hi > iLo then QSort(b, iLo, Hi);
   if Lo < iHi then QSort(b, Lo, iHi);
 end; // QSort();

 begin
  QSort(data, Low(data), High(data));
 end; // aQuickSort();

//////////////////////////////////////////////////////
// ���������

// ������� "��������" ��������� ������� �� ������� � ����� ������
// ���������
//  Arr - �������� ������
//  io,j0,ik,jk - ����������
//  *Relative - ���������� ������������ �� ������ ��������� ����������
// ������������ ��������
//  TImageArray
 function aCrop(const Arr: TImageArray; i0, j0, ik, jk: Smallint; Relative: Boolean = False): TImageArray;
 Var i, j: Word;
 Begin
  if Relative then begin
    ik := High(Arr) - ik;
    jk := High(Arr[0]) - jk;;
  end;
  aSetLength(Result, ik - i0 + 1, jk - j0 + 1);
  // check boarders
  i0 := ifthen(i0 < 0, 0, i0);
  ik := ifthen(ik > High(Arr), High(Arr), ik);
  j0 := ifthen(j0 < 0, 0, j0);
  jk := ifthen(jk > High(Arr[0]), High(Arr[0]), jk);
  // crop
  for i := i0 to ik do
    for j := j0 to jk do Result[i - i0,j - j0] := Arr[i,j];
 End; // aCrop();


////////////////////////////////////////////////////////////
// �������� ������ ��������
//

//////////////////////////////////////////////////////
// �������� �����

 // ������� ����������������� ������ �������� � �������, ������� ����������������� �������� ������
 function aLinearFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer): Boolean;
 Var i: Integer;
 Begin // �������� ������ � "�. ����. ��������� ����������������. ��� 3. ������ 6.1"
  // ��������� ��������� ��������
  aAddToArray(Arr, Value);
  // �������������
  i := -1;
  // �������� 0-�� �������
  if Value = Arr[i+1] then begin
    Inc(i);
    Result    := True;
    FindIndex := i;
    Exit;
  end
  else begin
    // �������� ���� ������
    repeat
      Inc(i, 2);
      if Value = Arr[i] then Break;
      if Value = Arr[i+1] then begin
        Inc(i);
        Break;
      end;
    until (True);
  end;
  // ����� �������?
  if i < High(Arr) then begin
    Result    := True;
    FindIndex := i;
  end
  else begin // �� �������
   Result     := False;
   FindIndex  := -1;
  end;
 End; // aLinearFind();

 // ������� ����������������� ������ �������� � �������, ������� ����������������� �������� ������
 function aLinearFind(Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean;
 Var i: Integer;
 Begin // �������� ������ � "�. ����. ��������� ����������������. ��� 3. ������ 6.1"
  // ��������� ��������� ��������
  aAddToArray(Arr, Value);
  // �������������
  i := -1;
  // �������� 0-�� �������
  if (Value.i = Arr[i+1].i) and (Value.j = Arr[i+1].j) then begin
    Inc(i);
    Result    := True;
    FindIndex := i;
    Exit;
  end
  else begin
    // �������� ���� ������
    repeat
      Inc(i, 2);
      if (Value.i = Arr[i].i) and (Value.j = Arr[i].j) then Break;
      if (Value.i = Arr[i+1].i) and (Value.j = Arr[i+1].j) then begin
        Inc(i);
        Break;
      end;
    until (True);
  end;
  // ����� �������?
  if i < High(Arr) then begin
    Result    := True;
    FindIndex := i;
  end
  else begin // �� �������
   Result     := False;
   FindIndex  := -1;
  end;
 End; // aLinearFind();

//////////////////////////////////////////////////////
// �������� �����

 // ������� ��������� ������ �������� � �������
 function aBinaryFind(Arr: TDByteArray; Value: Byte; out FindIndex: Integer; Precision: Boolean = False): Boolean;
 // ��������� ������������ ������
 function RecursionFind(L, R: Integer): Boolean;
 var M: Integer;
 begin
  if R < L then begin
    Result    := not Precision;
    FindIndex := ifthen(Precision, -1, L);
    Exit;
  end;
  M := (L + R) div 2;
  if Arr[M] = Value then begin
    Result    := True;
    FindIndex := M;
    Exit;
  end;
  if Arr[M] > Value then Result := RecursionFind(L, M - 1)
  else Result := RecursionFind(M + 1, R);
 end; // RecursionFind();

 Begin
  Result := RecursionFind(Low(Arr), High(Arr));
 End; // aBinaryFind();

//////////////////////////////////////////////////////
// ����� ��������

// ������� ������ �������� � ������� TPointPosArray
 function aFindInArray(var Arr: TPointPosArray; Value: TPointPosition; out FindIndex: Integer): Boolean;
 Begin
  // just linear find
  Result := aLinearFind(Arr, Value, FindIndex);
 End; // aFindInArray();

// ������� ������ �������� � ������� TDByteArray
 function aFindInArray(var Arr: TDByteArray; Value: Byte; out FindIndex: Integer; FindType: TFindType = mLinear; Precision: Boolean = False): Boolean;
 begin
  if FindType = mLinear then Result := aLinearFind(Arr, Value, FindIndex)
  else if FindType = mBinary then Result := aBinaryFind(Arr, Value, FindIndex, Precision)
  else begin // ���� �������� �� ����������
    if aCheckIncSort(Arr) or aCheckDecSort(Arr)
      then Result := aBinaryFind(Arr, Value, FindIndex, Precision)
    else Result := aLinearFind(Arr, Value, FindIndex);
  end;
 end; // aFindInArray();

//////////////////////////////////////////////////////
// ����� ������� ����������� ���������

// ���������� ������� ������������� �������� TDWordArray
 function aIndexOfMaxValue(const Arr: TDWordArray): Cardinal;
 var i, imax : Word;
     maxValue: Cardinal;
 begin
  imax     := 0;
  maxValue := 0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 end; // aIndexOfMaxValue();

// ���������� ������� ������������� �������� TLevelsArray
 function aIndexOfMaxValue(const Arr: TLevelsArray): Byte;
 var i, imax: Byte;
     maxValue: Cardinal;
 Begin
  imax     := 0;
  maxValue := 0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 End; // aIndexOfMaxValue();

// ���������� ������� ������������� �������� TDDoubleArray
 function aIndexOfMaxValue(const Arr: TDDoubleArray): Word;
 var i, imax: integer;
     maxValue: double;
 Begin
  imax     := 0;
  maxValue := 0.0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 End; // aIndexOfMaxValue();

//////////////////////////////////////////////////////
// ����� ��������� ��������� � ����������

// ���������� ��������� ��������� � ������� TDByteArray
 function aFindLocalsMin(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray;
 Var i, iMin                : word;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // ���� ��������
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
      //if CheckInc() then Break;
    end;
    if IncFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // ���� �����������
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// ���������� ��������� ���������� � ������� TDByteArray
 function aFindLocalsMax(const Arr: TDByteArray; i0: Word = 0; ik: Word = 0): TDWordArray;
 var i, iMax                : Word;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMax     := i0;
  first   := True;
  IncFlag := False;
  repeat
    DecFlag  := False;
    // ���� �����������
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // ���� ��������
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
     aAddToArray(Result, iMax);
     first   := False;
     IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();

// ���������� ��������� ��������� � ������� TDByteArray
 function aFindLocalsMin(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 Var i, iMin                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // ���� ��������
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
    end;
    if IncFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // ���� �����������
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// ���������� ��������� ���������� � ������� TDByteArray
 function aFindLocalsMax(const Arr: TDWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 var i, iMax                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMax     := i0;
  first    := True;
  IncFlag  := False;
  repeat
    DecFlag  := False;
    // ���� �����������
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // ���� ��������
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
     aAddToArray(Result, iMax);
     first   := False;
     IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();

// ���������� ��������� ��������� � ������� TDCardinalArray
 function aFindLocalsMin(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 Var i, iMin                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // ���� ��������
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
    end;
    if IncFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // ���� �����������
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// ���������� ��������� ���������� � ������� TDCardinalArray
 function aFindLocalsMax(const Arr: TDCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TDCardinalArray;
 var i, iMax                : Cardinal;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if ik = 0 then ik := High(Arr);
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMax     := i0;
  first    := True;
  IncFlag  := False;
  repeat
    DecFlag  := False;
    // ���� �����������
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // ���� ��������
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
      aAddToArray(Result, iMax);
      first   := False;
      IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();

// ���������� ��������� ��������� � ������� TLevelsArray
 function aFindLocalsMin(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray;
 Var i, iMin                : Word;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i        := i0 + 1;
  iMin     := i0;
  first    := True;
  DecFlag  := False;
  repeat
    IncFlag  := False;
    // ���� ��������
    while (Arr[i-1] > Arr[i])and(not CheckInc()) do begin
      iMin := i;
      Inc(i);
      IncFlag := True;
      //if CheckInc() then Break;
    end;
    if IncFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMin);
    end;
    if CheckInc() then Break;
    // ���� �����������
    while (Arr[i-1] <= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not IncFlag then DecFlag := True;
    end;
    if first and DecFlag then begin
      aAddToArray(Result, iMin);
      first   := False;
      DecFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMin();

// ���������� ��������� ���������� � ������� TLevelsArray
 function aFindLocalsMax(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TDByteArray;
 var i, iMax                : Word;
     DecFlag, IncFlag, first: Boolean;
 // �������� ��������
 function CheckInc(): boolean;
 begin
   if i > ik then Result := True
   else Result := False;
 end;

 Begin
  if i0 >= ik then Exit;
  SetLength(Result, 0);
  i       := i0 + 1;
  iMax    := i0;
  first   := True;
  IncFlag := False;
  repeat
    DecFlag  := False;
    // ���� �����������
    while (Arr[i-1] < Arr[i])and(not CheckInc()) do begin
      iMax := i;
      Inc(i);
      DecFlag := True;
    end;
    if DecFlag then begin
      // ����� �� ����� ��������
      aAddToArray(Result, iMax);
    end;
    if CheckInc() then Break;
    // ���� ��������
    while (Arr[i-1] >= Arr[i])and(not CheckInc()) do begin
      Inc(i);
      if first and not DecFlag then IncFlag := True;
    end;
    if first and IncFlag then begin
      aAddToArray(Result, iMax);
      first   := False;
      IncFlag := False;
    end;
  until (CheckInc());
 End; // aFindLocalsMax();


////////////////////////////////////////////////////////////
// ����������� �������� ������ � ���������
//

//////////////////////////////////////////////////////
// ���������� ����� ��������

// ��������� ����������(�����������) �������� �� ������ ������� � ������ �������� ���������
 procedure aAddFromArray(var Arr1: TPointPosArray; Arr2: TPointPosArray);
 Var i: Cardinal;
     index: integer;
 Begin
  for i := 0 to High(Arr2) do begin
    if aFindInArray(Arr1, Arr2[i], index) then Continue;
    aAddToArray(Arr1, Arr2[i]);
  end;
 End; // aAddFromArray();

////////////////////////////////////////////////////////////
// �������� �����������
//

//////////////////////////////////////////////////////
// ����������� � ������ ������

// ������� ����������� TImageArray � TDDouble2Array
 function aConvertToArray(var Arr: TImageArray): TDDouble2Array;
 var i, j: Cardinal;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]));
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr[i]) do
      Result[i,j] := Arr[i,j];
 End; // aConvertToArray();

// ������� ����������� TDDouble2Array � TImageArray
 function aConvertToArray(var Arr: TDDouble2Array): TImageArray;
 var i, j: Cardinal;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]));
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr[i]) do
      Result[i,j] := RoundToByte(Arr[i,j]);
 End; // aConvertToArray();

// ������� ����������� TSymbolsArray � TImagesArray
 function aConvertToArray(var Arr: TSymbolsArray): TImagesArray;
 var i: Cardinal;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do Result[i] := Arr[i].img;
 End; // aConvertToArray();

// ������� ����������� TImagesArray � TSymbolsArray
 function aConvertToArray(var Arr: TImagesArray): TSymbolsArray;
 var i: Cardinal;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do Result[i].img := Arr[i];
 End; // aConvertToArray();

// ��������� ����������� TImageArray � TDDouble2Array
 procedure aConvertToArray(var Arr: TImageArray; out Result: TDDouble2Array);
 var i, j: Cardinal;
 Begin
  aSetLength(Result, Length(Arr), Length(Arr[0]));
  for i := 0 to High(Arr) do
    for j := 0 to High(Arr[i]) do
      Result[i,j] := Arr[i,j];
 End; // aConvertToArray();

//////////////////////////////////////////////////////
// ����������� � ������

// ������� ��� ����������� TImageArray � String
 function aConvertToString(var Arr: TImageArray; StepLeft: Shortstring = ' '; StepDown: Shortstring = #13#10): String;
 var i,j       : Cardinal;
     tmpString : String;
     addSym    : Shortstring;
 Begin
  for i := 0 to High(Arr) do Begin
    tmpString := '';
    for j := 0 to High(Arr[i]) do tmpString := tmpString + StepLeft + IntToStr(Arr[i,j]);
    if i <> 0 then addSym := StepDown
    else addSym := '';
    Result := Result + addSym + Trim(tmpString);
  End;
 End; // aConvertToString()

//////////////////////////////////////////////////////
// ������



////////////////////////////////////////////////////////////////////////////////
//// ��������� � ������� �������������� ���������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ����������
//

//////////////////////////////////////////////////////
// ���������� ������������� �������

// ��������� ���������� ������������� ����������� �������
// ���������:
//  XArr, YArr - ����� � �������� � ������ �����
//  @SplineCoeff - ����������� ������������
//  *SplineType - ��� ������������� ������������ �������
 procedure aBuildSpline(var XArr, YArr: TDDoubleArray; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fCubic);
 Var DiscPointsLength: Integer;
 Begin
  SetLength(SplineCoeff, 0);
  DiscPointsLength := Length(XArr);
  // �������� ����������� �� ������
  if (SplineType = fAkima) and (DiscPointsLength < 5) then SplineType := fCubic;
  // ����������� ������������� �������
  case SplineType of
    fLinear : begin
                BuildLinearSpline(XArr, YArr, DiscPointsLength, SplineCoeff);
              end;
    fHermite: begin
                // �� �������� ��� ������ ���������
                Exit;
              end;
    fCubic  : begin
                BuildCubicSpline(XArr, YArr, DiscPointsLength, 0, 0.0, 0, 0.0, SplineCoeff);
              end;
    fAkima  : begin
                BuildAkimaSpline(XArr, YArr, DiscPointsLength, SplineCoeff);
              end;
  else Exit;
  end;
 End; // aBuildSpline();

// ��������� ���������� ������������� ���������� �������
// ���������:
//  XArr, YArr - ����� �� ����
//  FArr - �������� � �����
//  @SplineCoeff - ����������� ������������
//  *SplineType - ��� ������������� ������������ �������
 procedure aBuildSpline(var XArr, YArr: TDDoubleArray; var FArr: TDDouble2Array; out SplineCoeff: TDDoubleArray; SplineType: TSplineType = fBicubic);
 Begin
  SetLength(SplineCoeff, 0);
  // ����������� ������������� �������
  case SplineType of
    fBilinear : begin
                  BuildBilinearSpline(XArr, YArr,FArr, Length(YArr), Length(XArr), SplineCoeff);
                end;
    fBicubic  : begin
                  BuildBicubicSpline(XArr, YArr,FArr, Length(YArr), Length(XArr), SplineCoeff);
                end;
  else Exit;
  end;
 End; // aBuildSpline();

//////////////////////////////////////////////////////
// ���������� �������� ������� � �����

// ������� ���������� �������� � ����� ����������� �������
// ���������:
//  SplineCoeff - ����������� ������������ �������
//  Value - ����� ����������
// ������������ ��������:
//  Double
 function aSplineInterpolation(var SplineCoeff: TDDoubleArray; var Value: Double): Double;
 Begin
  Result := SplineInterpolation(SplineCoeff, Value);
 End; // aSplineInterpolation();

// ������� ���������� �������� � ����� ���������� �������
// ���������:
//  SplineCoeff - ����������� ������������ �������
//  ValueX, ValueY - ����� ����������
// ������������ ��������:
//  Double
 function aSplineInterpolation2D(var SplineCoeff: TDDoubleArray; var ValueX, ValueY: Double): Double;
 Begin
  Result := SplineInterpolation2D(SplineCoeff, ValueX, ValueY);
 End; // aSplineInterpolation();

//////////////////////////////////////////////////////
// ���������� ������ �� 7 ������

// ��������� ����������� ������� �� 7 ������ ��� ����������� �������� �������
// ���������:
//  ValueArray - �������������� ������
//  Coef       - �������������
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aSevenPointNonLinearSmoothing(var ValueArray: TDDoubleArray; Coef: integer);
 var j, k, i : integer;
     resv    : array of array of double;
 Begin
  // ��������� ������������ �����������
  if (Coef = 0) or (Coef = 1) then Exit;
  SetLength(resv, Coef, (Length(ValueArray) div Coef));
  for j := 0 to Coef - 1 do
    for i := 0 to Length(resv[0]) - 1 do
      resv[j][i] := ValueArray[i*Coef + j];
  // ���������� �������������
  for k := 0 to Coef - 1 do
    for j := 0 to Length(resv[0]) - 1 do begin
      if j = 0 then
        resv[k][j] := (39*ValueArray[j*Coef + k] + 8*ValueArray[(j + 1)*Coef + k] -
          4*(ValueArray[(j + 2) * Coef + k] + ValueArray[(j + 3)*Coef + k] - ValueArray[(j + 4) * Coef + k]) +
          ValueArray[(j + 5)*Coef + k] - 2*ValueArray[(j + 6)*Coef + k])/42;
      if j = 1 then
        resv[k][j] := (8*ValueArray[j*Coef + k] +
          19*ValueArray[(j + 1)*Coef + k] + 16*ValueArray[(j + 2)*Coef + k] +
          6*ValueArray[(j + 3)*Coef + k] - 4*ValueArray[(j + 4)*Coef + k] -
          7*ValueArray[(j + 5)*Coef + k] + 4*ValueArray[(j + 6)*Coef + k])/42;
      if j = 2 then
        resv[k][j] := (-4*ValueArray[j*Coef + k] +
          16*ValueArray[(j + 1)*Coef + k] + 19*ValueArray[(j + 2)*Coef + k] +
          12*ValueArray[(j + 3)*Coef + k] + 2*ValueArray[(j + 4)*Coef + k] -
          4*ValueArray[(j + 5)*Coef + k] + ValueArray[(j + 6)*Coef + k])/42;
      if (j > 2) and (j < Length(resv[0]) - 3) then
        resv[k][j] := (7*ValueArray[j*Coef + k] +
        6*(ValueArray[(j - 1)*Coef + k] + ValueArray[(j + 1)*Coef + k]) +
        3*(ValueArray[(j - 2)*Coef + k] + ValueArray[(j + 2)*Coef + k]) -
        2*(ValueArray[(j - 3)*Coef + k] + ValueArray[(j + 3)*Coef + k]))/21;
      if j = Length(resv[0]) - 3 then
        resv[k][j] := (-4*ValueArray[j*Coef + k] +
          16*ValueArray[(j - 1)*Coef + k] + 19*ValueArray[(j - 2)*Coef + k] +
          12*ValueArray[(j - 3)*Coef + k] + 2*ValueArray[(j - 4)*Coef + k] -
          4*ValueArray[(j - 5)*Coef + k] + ValueArray[(j - 6)*Coef + k])/42;
      if j = Length(resv[0]) - 2 then
        resv[k][j] := (8*ValueArray[j*Coef + k] +
          19*ValueArray[(j - 1)*Coef + k] + 16*ValueArray[(j - 2)*Coef + k] +
          6*ValueArray[(j - 3)*Coef + k] - 4*ValueArray[(j - 4)*Coef + k] -
          7*ValueArray[(j - 5)*Coef + k] + 4*ValueArray[(j - 6)*Coef + k])/42;
      if j = Length(resv[0]) - 1 then
        resv[k][j] := (39*ValueArray[j*Coef + k] +
          8*ValueArray[(j - 1)*Coef + k] - 4*ValueArray[(j - 2)*Coef + k] -
          4*ValueArray[(j - 3)*Coef + k] - 4*ValueArray[(j - 4)*Coef + k] +
          ValueArray[(j - 5)*Coef + k] - 2*ValueArray[(j - 6)*Coef + k])/42;
    end;
  // ����������
  for j := Coef to Length(resv[0]) - Coef do
    for k := 0 to Coef - 1 do
      ValueArray[j*Coef + k] := resv[k][j];
 End; // SevenPointNonLinearSmoothing();

//////////////////////////////////////////////////////
// ���������� ������ ����������� ���������

// ��������� ����������� ������� ����������� ��������� ��� ����������� �������� �������
// ���������:
//  ValueArray  - �������������� ������
//  Dsc         - ����������� �����������
//  Coef        - �������������
//Dsc*Coef - ��� ����������
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aCubicSplineSmoothing(var ValueArray: TDDoubleArray; Dsc: double; Coef: integer);
 var j, k, i, N : integer;
     resv       : TDDouble2Array;
     av, h, mi, mj, v1, v2: double;
 begin
  if (Coef = 0) or (Coef = 1) then Exit;
  N := Length(ValueArray);
  SetLength(resv, Coef, N);
  h := Coef*Dsc;
  mi := 0.0; mj := 0.0;
  // ���������� �����.
  for k := 0 to Coef - 1 do
    for j := 0 to (N div Coef) - 2 do begin
      if j = 0 then begin
        mi := (4*ValueArray[(j + 1)*Coef + k] - ValueArray[(j + 2)*Coef + k] - 3*ValueArray[j*Coef + k])/2;
        mj := (ValueArray[(j + 2)*Coef + k] - ValueArray[j*Coef + k])/2;
      end;
      if j = (N div Coef) - 2 then begin
        mi := (ValueArray[(j + 1)*Coef + k] - ValueArray[(j - 1)*Coef + k])/2;
        mj := (3*ValueArray[(j + 1)*Coef + k] + ValueArray[(j - 1)*Coef + k] - 4*ValueArray[j*Coef + k])/2;
      end;
      if (j > 0) and (j < ((N div Coef) - 2)) then begin
        mi := (ValueArray[(j + 1)*Coef + k] - ValueArray[(j - 1)*Coef + k])/2;
        mj := (ValueArray[(j + 2)*Coef + k] - ValueArray[j*Coef + k])/2;
      end;
      for i := j*Coef to (j + 1)*Coef do begin
        v1 := ((j + 1)*Coef + k)*Dsc - (i + k)*Dsc;
        v2 := (i + k)*Dsc - (j*Coef + k)*Dsc;
        resv[k][i + k] := (Sqr(v1)*(2*v2 + h)*ValueArray[j*Coef + k] +
          Sqr(v2)*(2*v1 + h)*ValueArray[(j + 1)*Coef + k] + (Sqr(v1)*v2*mi + Sqr(v2)*(-v1)*mj)/2)/h/h/h;
      end;
    end;
  // ����������
  for j := Coef to N - 1 - Coef do begin
    av := 0;
    for k := 0 to Coef - 1 do av := av + resv[k][j];
    av := av/Coef;
    ValueArray[j] := av;
  end;
end; // CubicSplineSmoothing();

//////////////////////////////////////////////////////
// �����������

// ��������� ���������� ������� � ����������� �� ����������
// ���������:
//  Arr - �������������� ������
//  *SmoothType - ��� �����������
//  Coef - �������������
//  *Dsc - ����������� ����������� (������ ��� fCubicSpline)
//  *CycledFilter - ��������� �� ������ � �����
 procedure aSmoothing(var Arr: TDDoubleArray; Coef: Word; SmoothType: TSmoothingType = fCubicSpline;
                      Dsc: Double = 1.0; CycledFilter: Boolean = false);
 Var j: Word;
 Begin
  case SmoothType of
    fSevenNonLinear: begin
                      if CycledFilter then
                       for j := 2 to Coef do
                         aSevenPointNonLinearSmoothing(Arr, j)
                       else
                         aSevenPointNonLinearSmoothing(Arr, Coef);
                     end;
    fCubicSpline   : begin
                      aCubicSplineSmoothing(Arr, Dsc, Coef);
                     end;
  end;
 End; // aSmoothing();

//////////////////////////////////////////////////////
// ���������� ��������������

// ��������� ���������� �������� ������������ �� �������
//�.�. ���� � ������� ������� �������� �������, ��� ����� �������������
// ���������:
//  Arr - ������ � ��������������
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 22.04.2009
 procedure aLinearTrendExclusion(var Arr: TDDoubleArray);
 var i, N      : Integer;
     b0, b1, nx: Double;
 begin
  N := Length(Arr);
  nx := 0;
  for i := 0 to N - 1 do nx := nx + (i + 1)*Arr[i];
  b0 := (2*(2*N + 1)*Sum(Arr) - 6*nx)/(N*(N - 1));
  b1 := (12*nx - 6*(N + 1)*Sum(Arr))/(N*(N - 1)*(N + 1));
  for i := 0 to N - 1 do Arr[i] := Arr[i] - (b0 + i*b1);
 end; // aLinearTrendExclusion();


////////////////////////////////////////////////////////////
// ������������ ��������������
//

//////////////////////////////////////////////////////
// �����

//��������� �������������� ������� �����
// ���������:
//  ValueArray   - �������������� ������
//  NumGarmonics - ����� ��������
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aFourierAnalysis(var ValueArray: TDDoubleArray; NumGarmonics: integer);
 Var i, j, N        : integer;
     yn, ap, bp     : double;
     AFCoef, BFCoef : TDDoubleArray;
 Begin
  N := Length(ValueArray);
  SetLength(AFCoef, NumGarmonics);
  SetLength(BFCoef, NumGarmonics);
  AFCoef[0] := Sum(ValueArray)/N;
  BFCoef[0] := 0;
  for i := 1 to NumGarmonics - 1 do begin
    AFCoef[i] := 0;
    BFCoef[i] := 0;
    for j := 0 to N - 1 do begin
      AFCoef[i] := AFCoef[i] + ValueArray[j] * cos(Pi* i * j * 2 / N);
      BFCoef[i] := BFCoef[i] + ValueArray[j] * sin(Pi * i * j * 2 / N);
    end;
    AFCoef[i] := AFCoef[i] * 2 / N;
    BFCoef[i] := BFCoef[i] * 2 / N;
  end;
  for j := 0 to N - 1 do begin
    //yn := 0;
    ap := 0;
    bp := 0;
    for i := 1 to NumGarmonics - 1 do begin
      ap := ap + AFCoef[i] * cos(2 * Pi * i * (j / N));
      bp := bp + BFCoef[i] * sin(2 * Pi * i * (j / N));
    end;
    yn := AFCoef[0] + ap + bp;
    ValueArray[j] := yn;
  end;
 End; // aFourierAnalysis();

//////////////////////////////////////////////////////
// ������� ��� ������

// ������� ���������� ������� ��� ������, ���������� ������� �� �������
// �.�. ���������� ��������������
// ���������:
//  arr         - �������� ������
//  i0, ik      - �������
//  *Method     - ����� ������� 1..4
//  *BindToZero - ������ �� �� ����
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 function aCalculateAreaOfArray(var arr: TDDoubleArray; i0, ik: integer; Method: byte = 1; BindToZero: boolean = true): Double;
 Var i        : Integer;
     sq, subv : Double;
 Begin
  if arr = nil then Result := 0
  else begin
    sq := 0;
    if BindToZero then subv := (arr[ik] + arr[i0])/2
    else subv := 0;
    for i := i0 to ik - 1 do begin
      if Method = 1 then
        sq := sq + Abs(arr[i] - subv) + (Abs(arr[i+1] - subv) - Abs(arr[i] - subv))/2;
      if Method = 2 then
        sq := sq + Abs(arr[i] - subv) + (Abs(arr[i + 1] - subv) - Abs(arr[i] - subv))/2 - 1/(48*Power(0.5, 1.5));
      if Method = 3 then
        if (i mod 2) = 1 then
          sq := sq + 2 * Abs(arr[i] - subv);
      if Method = 4 then
        if (i mod 2) = 1 then
          sq := sq + 2*Abs(arr[i] - subv) - 1/(96*Power(0.5, 1.5));
    end;
    Result := sq;
  end;
 End; // aCalculateAreaOfArray();


////////////////////////////////////////////////////////////
// �������������� �����������/���������������
//

//////////////////////////////////////////////////////
// ���������� ������

// ��������� ���������� ������� �������� ������ ����� ������ � �����
// ���������:
//  Arr        - �������������� ������
//  SplitValue - ���������� �����
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aIncreaseLength(var Arr: TDDoubleArray; SplitValue: integer);
 var sv, N, i: integer;
     bv, ev  : double;
 Begin
  N := Length(Arr);
  sv := 10*SplitValue;
  bv := 0;
  ev := 0;
  for i := 0 to 9 do bv := bv + Arr[i];
  bv := bv/10;
  for i := N - 1 downto N - 10 do ev := ev + Arr[i];
  ev := ev/10;
  SetLength(Arr, N + sv);
  for i := N - 1 downto 0 do Arr[i + trunc(sv/2)] := Arr[i];
  for i := trunc(sv/2) - 1 downto 0 do Arr[i] := bv;
  for i := N + trunc(sv/2) to N + sv - 1 do Arr[i] := ev;
 End; // aIncreaseLength();

//////////////////////////////////////////////////////
// ���������� ������

// ��������� ���������� ������� �������� ������ ����� ������ � �����
// ���������:
//  Arr        - �������������� ������
//  SplitValue - ���������� �����
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 procedure aDecreaseLength(var Arr: TDDoubleArray; SplitValue: integer);
 Var sv, N, i: integer;
 Begin
  N := Length(Arr);
  sv := 10*SplitValue;
  for i := 0 to N - sv - 1 do Arr[i] := Arr[i + trunc(sv / 2)];
  SetLength(Arr, N - sv);
 End; // aDecreaseLength();

//////////////////////////////////////////////////////
// ���������� �������

// ������� ���������� ������� �������� ������ ����� ����� 2-�� ��������� �������
// ���������:
//  Arr        - �������������� ������
//  ExpandCoef - ���������� �����
//***����***
//�����:       lookin, lookin@mail.ru, ������������, 30 ������ 2002 �.
//����������:  Simkin A.V., simkin.av@gmail.com, 16.04.2009
 function aExpandLength(var Arr: TDDoubleArray; ExpandCoef: integer): TDDoubleArray;
 var i, k, N, sub: integer;
     diap: double;
 begin
  N   := Length(Arr);
  sub := ExpandCoef - 1;
  SetLength(Result, N*ExpandCoef - sub);
  for i := 0 to N - 1 do begin
    Result[i*ExpandCoef] := Arr[i];
    if i <> 0 then begin
      diap := (Result[i*ExpandCoef] - Result[(i - 1)*ExpandCoef]);
      for k := 0 to ExpandCoef - 1 do
        Result[(i - 1)*ExpandCoef + k] := Result[(i - 1)*ExpandCoef] + diap*(k/ExpandCoef);
    end;
  end;
 end; // aExpandLength();

//////////////////////////////////////////////////////
// ��������� ������� ������� AverageArea

// ������� ��������� ������� ������� ������� �������� � ������� ��������
// ������������� ������������, ������ ��� ���������� ������� ����������� (dx,dy>1)
// ���������:
//  Arr         - �������� ������
//  NewH, NewW  - ����� ������� �������
// ������������ ��������:
//  TImageArray
 function aAverageAreaResize(var Arr: TImageArray; NewH, NewW: Word): TImageArray;
 var x0, x1, y0, y1, dx, dy : single; // ���������� ��������� �������
     x, y, px, py, points   : integer;
     Grey                   : Cardinal;
     ArrHeight, ArrWidth    : Word;
 // ���������� ����������
 function MyRound(x: Double): Integer;
  begin
    Result := Trunc(x);
    if Frac(x) >= 0.5 then
      if x >= 0 then Result := Result + 1
      else Result := Result - 1;
  end;

 Begin
  aSetLength(Result, NewH, NewW);
  ArrHeight := Length(Arr);
  ArrWidth  := Length(Arr[0]);
  // ���������� ������� ������������ ������� � �������� �������
  dx        := ArrWidth/NewW;
  dy        := ArrHeight/NewH;
  // if (dx<1)or(dy<1) then // ���������� ������������ ������ ��������
  // ���������
  y1 := 0;
  for y := 0 to NewH - 1 do
   begin
    // ���������� ��������� � ��������
    //���������� �� ������ � �������� �������
    y0 := y1;
    y1 := y0 + dy;
    x1 := 0;
    for x := 0 to NewW - 1 do
    begin
     // ���������� ��������� � ��������
     //���������� �� ������ � �������� �������
     x0 := x1;
     x1 := x0 + dx;
     // ��������� ������� ��������� � �������
     Grey   := 0;
     points := 0;
     for py := MyRound(y0) to MyRound(y1) do
      begin
       for px := MyRound(x0) to MyRound(x1) do
        begin
         Inc(points);
         if (px >= ArrWidth)or(py >= ArrHeight) then Inc(Grey, 255)
         else Inc(Grey, Arr[px,py]);
        end;
      end;
     Result[x,y] := ifthen(points = 0, 255, MyRound(Grey/points));
    end;
   end;
 End; // aAverageAreaResize();

// ������� ��������� ������� ������� ������� �������� � ������� ��������
// ������������� ������������, ������ ��� ���������� ������� ����������� (dx,dy>1)
// ���������:
//  Arr         - �������� ������
//  NewH, NewW  - ����� ������� �������
// ������������ ��������:
//  TImageArray
 function aAverageAreaResize(var Arr: TDDouble2Array; NewH, NewW: Cardinal): TDDouble2Array;
 var x0, x1, y0, y1, dx, dy : Double; // ���������� ��������� �������
     x, y, px, py, points   : integer;
     Grey                   : Double;
     ArrHeight, ArrWidth    : integer;
 // ���������� ����������
 function MyRound(x: Double): Integer;
  begin
    Result := Trunc(x);
    if Frac(x) >= 0.5 then
      if x >= 0 then Result := Result + 1
      else Result := Result - 1;
  end;

 Begin
  aSetLength(Result, NewH, NewW);
  ArrHeight := Length(Arr);
  ArrWidth  := Length(Arr[0]);
  // ���������� ������� ������������ ������� � �������� �������
  dx        := ArrWidth/NewW;
  dy        := ArrHeight/NewH;
  // if (dx<1)or(dy<1) then // ���������� ������������ ������ ��������
  // ���������
  y1 := 0.0;
  for y := 0 to NewH - 1 do
   begin
    // ���������� ��������� � ��������
    //���������� �� ������ � �������� �������
    y0 := y1;
    y1 := y0 + dy;
    x1 := 0.0;
    for x := 0 to NewW - 1 do
    begin
     // ���������� ��������� � ��������
     //���������� �� ������ � �������� �������
     x0 := x1;
     x1 := x0 + dx;
     // ��������� ������� ��������� � �������
     Grey   := 0.0;
     points := 0;
     for py := MyRound(y0) to MyRound(y1) do
      begin
       for px := MyRound(x0) to MyRound(x1) do
        begin
         Inc(points);
         if (px >= ArrWidth)or(py >= ArrHeight) then Grey := Grey + 255//Inc(Grey, 255)
         else Grey := Grey +  Arr[px,py];//Inc(Grey, Arr[px,py]);
        end;
      end;
     Result[x,y] := ifthen(points = 0, 255, MyRound(Grey/points));
    end;
   end;
 End; // aAverageAreaResize();

//////////////////////////////////////////////////////
// ��������� �������

// ������� ��������� ������� ������� �� ���������� ���� ��������������
// ���������:
//  Arr         - �������������� ������
//  newH, newW  - ����� �����������
//  *ResizeType - ��� ��������������
// ������������ ��������:
//  ������ � ����� �����������
 function aResize(var Arr: TDDouble2Array; newH, newW: Cardinal; ResizeType: TResizeType = fBilinearSpline): TDDouble2Array;
 Begin
  aSetLength(Result, newH, newW);
  case ResizeType of
    fAverageArea    : Result := aAverageAreaResize(Arr, newH, newW);
    fBilinearSpline : BilinearResampleCartesian(Arr, Length(Arr), Length(Arr[0]), Result, newH, newW);
    fBicubicSpline  : BicubicResampleCartesian(Arr, Length(Arr), Length(Arr[0]), Result, newH, newW);
    fBiakimaSpline  : BiakimaResampleCartesian(Arr, Length(Arr), Length(Arr[0]), Result, newH, newW);
  end;
 End; // aResize();

// ������� ��������� ������� ������� �� ���������� ���� ��������������
// ���������:
//  Arr         - �������������� ������
//  newH, newW  - ����� �����������
//  *ResizeType - ��� ��������������
// ������������ ��������:
//  ������ � ����� �����������
 function aResize(var Arr: TImageArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImageArray;
 Var tmp: TDDouble2Array;
 Begin
  //��������! ���� �� �������� ���������� ��������������� �����������, ��� ������ ��������
  //����� TDDouble2Array, ��� ����������� ���������� ����� �������������� ��������
  aSetLength(Result, newH, newW);
  case ResizeType of
    fAverageArea    : Result := aAverageAreaResize(Arr, newH, newW);
    fBilinearSpline : begin
                        BilinearResampleCartesian(aConvertToArray(Arr), Length(Arr), Length(Arr[0]), tmp, newH, newW);
                        Result := aConvertToArray(tmp);
                      end;
    fBicubicSpline  : begin
                        BicubicResampleCartesian(aConvertToArray(Arr), Length(Arr), Length(Arr[0]), tmp, newH, newW);
                        Result := aConvertToArray(tmp);
                      end;
    fBiakimaSpline  : begin
                        BiakimaResampleCartesian(aConvertToArray(Arr), Length(Arr), Length(Arr[0]), tmp, newH, newW);
                        Result := aConvertToArray(tmp);
                      end;
  end;
 End; // aResize();

// ������� ��������� ������� ������� �� ���������� ���� ��������������
// ���������:
//  Arr         - �������������� ������
//  newH, newW  - ����� �����������
//  *ResizeType - ��� ��������������
// ������������ ��������:
//  ������ � ����� �����������
 function aResize(var Arr: TImagesArray; newH, newW: Word; ResizeType: TResizeType = fBilinearSpline): TImagesArray;
 var i        : Cardinal;
     ResizeArr: TImageArray;
 Begin
  SetLength(Result, Length(Arr));
  for i := 0 to High(Arr) do
  begin
    ResizeArr := aResize(Arr[i], newH, newW, ResizeType);
    Result[i] := ResizeArr;
  end;
 End; // aResize();


end. // ImgLibArrayExt
