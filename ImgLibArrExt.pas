{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{              BMSTU n.a. Bauman, ICS-1                 }
{           Copyright (c) 2009, Simkin A.V.             }
{                                                       }
{*******************************************************}
{        Library Version 0.8.0a from 15.04.2009         }
{*******************************************************}
{       'Array Extension Works' from 15.04.2009         }
{*******************************************************}
unit ImgLibArrExt;
 { ������ ������ � �������� ��������� ���������� }
interface {�������� ��������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  ImgLibTypes, // ����������� ������ ����������
  Windows;     // ��������� ������

  ////////////////////////////////////////////////////////////
  // �������� ��������� � ������� ������
  //
  // ��������� �������
  procedure aSetLength(var Arr: TImageArray; H, W: Word); overload; stdcall;
  procedure aSetLength(var Arr: TImagesArray; K, H, W: Word); overload; stdcall;
  procedure aSetLength(var Arr: TSymbolsArray; K: Word); overload; stdcall;
  procedure aSetLength(var Arr: TPointPar2Array; H, W: Word); overload; stdcall;
  // ����� ��������
  function aFindInArray(const Arr: TPointPosArray; Value: TPointPosition): Boolean; overload; stdcall;

implementation {���������� ������}

////////////////////////////////////////////////////////////////////////////////
//// ��������� ��������� � �������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//// �������� ��������� � ������� ���������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ������� � �������� ��������� � �������
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

//////////////////////////////////////////////////////
// ����������

// ���������� ��������� � ������� TWordArray
 procedure aBubbleSort(var data: TWordArray); overload;
 var i, j: Integer;
     tmp : Word;
 begin
 for i := 1 to High(data) do
  for j := 0 to High(data) - i do
    if data[j] < data[j+1] then
      begin
       tmp       := data[j];
       data[j]   := data[j+1];
       data[j+1] := tmp;
      end;
 end; // aBubbleSort();

// ���������� ��������� � ������� TSymbolsArray
 procedure aBubbleSort(var data: TSymbolsArray); overload;
 var i, j: Integer;
     tmp : TSymbol;
 begin
 for i := 1 to High(data) do
  for j := 0 to High(data) - i do
    if data[j].position > data[j+1].position then
      begin
       tmp       := data[j];
       data[j]   := data[j+1];
       data[j+1] := tmp;
      end;
 end; // aBubbleSort();

// ���������� ��������� � ������� TPointPosArray
 procedure aBubbleSort(var data: TPointPosArray; SortRec: Char = 'i'); overload;
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

// ���������� ���������� QuickSort � ������� TByteArray
 procedure aQuickSort(var data: TByteArray); overload;
 // ��������� ��������
 procedure QSort(var b: TByteArray; iLo, iHi: Integer);
 var   Lo, Hi: Integer;
       Mid, t: Byte;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := b[(Lo + Hi) div 2];
   repeat
     while b[Lo] < Mid do Inc(Lo);
     while b[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then
     begin
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

// ���������� ���������� QuickSort � ������� TWordArray
 procedure aQuickSort(var data: TWordArray); overload;
 // ��������� ��������
 procedure QSort(var b: TWordArray; iLo, iHi: Integer);
 var   Lo, Hi: Integer;
       Mid, t: Word;
 begin
   Lo := iLo;
   Hi := iHi;
   Mid := b[(Lo + Hi) div 2];
   repeat
     while b[Lo] < Mid do Inc(Lo);
     while b[Hi] > Mid do Dec(Hi);
     if Lo <= Hi then
     begin
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
// ����� ��������

// ������� ������ �������� � ������� TPointPosArray
 function aFindInArray(const Arr: TPointPosArray; Value: TPointPosition): Boolean;
 var i: integer;
 begin
  for i := 0 to High(Arr) do
  begin
    if (Arr[i].i = Value.i)and(Arr[i].j = Value.j) then
    begin
      Result :=  True;
      Exit;
    end;
  end;
  Result := False;
 end; // uFindInArray();

// ������� ������ �������� � ������� TByteArray
 function aFindInArray(const Arr: TByteArray; Value: Byte; out FindIndex: Word; Precision: Boolean = False): Boolean; overload;
 // �������� ������������
 function CheckIncSort(): Boolean;
 var i: Word;
 begin
  i := 0;
  while (i < High(Arr) - 1) and (Arr[i] <= Arr[i+1]) do Inc(i);
  if (i = High(Arr) - 1) and (Arr[i] <= Arr[i+1]) then Result := True
  else Result := False;
 end;
 // �������� ��������
 function CheckDecSort(): Boolean;
 var i: Word;
 begin
  i := 0;
  while (i < High(Arr) - 1) and (Arr[i] >= Arr[i+1]) do Inc(i);
  if (i = High(Arr) - 1) and (Arr[i] >= Arr[i+1]) then Result := True
  else Result := False;
 end;
 // �������� �����
 function BinaryFind(L, R: Word): Boolean;
  var M: Word;
  begin
    if R < L then
    begin
      Result    := not Precision;
      FindIndex := L;//ifthen(Precision, -1, L);
      Exit;
    end;
    M := (L + R) div 2;
    if Arr[M] = Value then
    begin
      Result    := True;
      FindIndex := M;
      Exit;
    end;
    if Arr[M] > Value then
      Result := BinaryFind(L, M - 1)
    else
      Result := BinaryFind(M + 1, R)
  end;
 // �������� �����
 function LinearFind(): Boolean;
 var i: Word;
 begin
  for i := 0 to High(Arr) do begin
    if Arr[i] = Value then begin
      Result    := True;
      FindIndex := i;
      Exit;
    end;
  end;
  Result := False;
 end;

 begin
  if CheckIncSort or CheckDecSort then begin
    // binary
    Result := BinaryFind(Low(Arr), High(Arr));
  end
  else begin
    // linear
    Result := LinearFind;
  end;
 end; // uFindInArray();

//////////////////////////////////////////////////////
// ���������� ������ ��������

// ��������� ��������� ����� ������� � ������ TWordArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TByteArray; New: Word); overload;
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TWordArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TWordArray; New: Word); overload;
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TCardinalArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TCardinalArray; New: Cardinal); overload;
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TImagesArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TImagesArray; New: TImageArray); overload;
 begin
  SetLength(Arr, Length(Arr) + 1);
  aSetLength(Arr[High(Arr)], Length(New), Length(New[0]));
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TSymbolsArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TSymbolsArray; New: TSymbol); overload;
 begin
  aSetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

// ��������� ��������� ����� ������� � ������ TPointPosArray (���������� ��� ������)
 procedure aAddToArray(var Arr: TPointPosArray; New: TPointPosition); overload;
 begin
  SetLength(Arr, Length(Arr) + 1);
  Arr[High(Arr)] := New;
 end; // aAddToArray();

//////////////////////////////////////////////////////
// ���������� ����� ��������

// ��������� ����������(�����������) �������� �� ������ ������� � ������ �������� ���������
 procedure aAddFromArray(var Arr1: TPointPosArray; Arr2: TPointPosArray); overload;
 var i: Cardinal;
 begin
  for i := 0 to High(Arr2) do
  begin
    if aFindInArray(Arr1, Arr2[i]) then Continue;
    aAddToArray(Arr1, Arr2[i]);
  end;
 end; // aAddFromArray();

//////////////////////////////////////////////////////
// ������������ ��������

// ���������� ������� ������������� �������� TWordArray
 function aIndexOfMaxValue(const Arr: TWordArray): Word; overload;
 var i, imax : Word;
     maxValue: Cardinal;
 begin
  imax     := 0;
  maxValue := 0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then
    begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 end; // aIndexOfMaxValue();

// ���������� ������� ������������� �������� TLevelsArray
 function aIndexOfMaxValue(const Arr: TLevelsArray): Byte; overload;
 var i, imax: Byte;
     maxValue: Cardinal;
 Begin
  imax     := 0;
  maxValue := 0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then
    begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 End; // aIndexOfMaxValue();

// ���������� ������� ������������� �������� TDoubleArray
 function aIndexOfMaxValue(const Arr: TDoubleArray): Word; overload;
 var i, imax: integer;
     maxValue: double;
 Begin
  imax     := 0;
  maxValue := 0.0;
  for i := 0 to High(Arr) do
  begin
    if maxValue < Arr[i] then
    begin
      maxValue := Arr[i];
      imax     := i;
    end;
  end;
  Result := imax;
 End; // aIndexOfMaxValue();

//////////////////////////////////////////////////////
// ����� ��������� ��������� � ����������

// ���������� ��������� ��������� � ������� TByteArray
 function aFindLocalMin(const Arr: TByteArray; i0: Word = 0; ik: Word = 0): TWordArray; overload;
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
 End; // aFindLocalMin();

// ���������� ��������� ���������� � ������� TByteArray
 function aFindLocalMax(const Arr: TByteArray; i0: Word = 0; ik: Word = 0): TWordArray; overload;
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
 End; // aFindLocalMax();

// ���������� ��������� ��������� � ������� TByteArray
 function aFindLocalMin(const Arr: TWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TCardinalArray; overload;
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
 End; // aFindLocalMin();

// ���������� ��������� ���������� � ������� TByteArray
 function aFindLocalMax(const Arr: TWordArray; i0: Cardinal = 0; ik: Cardinal = 0): TCardinalArray; overload;
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
 End; // aFindLocalMax();

// ���������� ��������� ��������� � ������� TCardinalArray
 function aFindLocalMin(const Arr: TCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TCardinalArray; overload;
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
 End; // aFindLocalMin();

// ���������� ��������� ���������� � ������� TCardinalArray
 function aFindLocalMax(const Arr: TCardinalArray; i0: Cardinal = 0; ik: Cardinal = 0): TCardinalArray; overload;
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
 End; // aFindLocalMax();

// ���������� ��������� ��������� � ������� TLevelsArray
 function aFindLocalMin(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TByteArray; overload;
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
 End; // aFindLocalMin();

// ���������� ��������� ���������� � ������� TLevelsArray
 function aFindLocalMax(const Arr: TLevelsArray; i0: Byte = 0; ik: Byte = MAXBYTE): TByteArray; overload;
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
 End; // aFindLocalMax();


//////////////////////////////////////////////////////
// ������

end. // ImgLibArrayExt
