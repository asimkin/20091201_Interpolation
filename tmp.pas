{ **** UBPFD *********** by delphibase.endimus.com ****
>> Фильтрация, регрессия, работа с массивом и серией

Модуль предназначен для выполнения процедур:
- фильтрации
- регрессии
- операций с массивами
- операций с сериями

Зависимости: Math, TeEngine, Graphics, SysUtils, Dialogs
Автор:       lookin, lookin@mail.ru, Екатеринбург
Copyright:   lookin
Дата:        30 апреля 2002 г.
***************************************************** }
{*******************************************************}
{          Modify and Adaptive by Simkin A.V.           }
{                         to                            }
{      Image Library for Bachelor Diploma Project       }
{              BMSTU n.a. Bauman, ICS-1                 }
{           Copyright (c) 2009, Simkin A.V.             }
{                                                       }
{*******************************************************}
{                      16.04.2009                       }
{*******************************************************}
unit tmp;

interface

uses Math, SysUtils, ImgLibTypes;

procedure ArrayExpanding(var ValueArray: TDDoubleArray; ExpandCoef: integer);
procedure ArrayLengthening(var ValueArray: TDDoubleArray; SplitValue: integer);
procedure ArrayShortening(var ValueArray: TDDoubleArray; SplitValue: integer);
procedure CubicSplineSmoothing(var ValueArray: TDDoubleArray; Dsc: double;
  Coef: integer);
procedure SevenPointNonLinearSmoothing(var ValueArray: TDDoubleArray;
  Dsc: double; Coef: integer);
procedure FourierAnalysis(var ValueArray: TDDoubleArray; NumGarmonics: integer);
procedure DoArraySmoothing(var ValueArray: TDDoubleArray; FilterType: integer;
  Dsc: double; SplitCoef, ExpandCoef: integer;
  CycledFilter: boolean);

procedure CheckArrayBounds(var CArray: TDDoubleArray; var FromPoint, ToPoint:
  integer);


function CalculateAreaOfArray(var SourceArray: TDDoubleArray;
  FromPoint, ToPoint, Method: integer;
  BindToZero: boolean): double;

procedure LinearTrendExclusion(var ValueArray: TDDoubleArray);


implementation

//Нелинейный фильтр по 7 точкам

procedure SevenPointNonLinearSmoothing(var ValueArray: TDDoubleArray;
  Dsc: double; Coef: integer);
var
  j, k, i: integer;
  resv: array of array of double;
begin
  if (Coef = 0) or (Coef = 1) then
    Exit;
  SetLength(resv, Coef, (Length(ValueArray) div Coef));
  for j := 0 to Coef - 1 do
    for i := 0 to Length(resv[0]) - 1 do
      resv[j][i] := ValueArray[i * Coef + j];
  for k := 0 to Coef - 1 do
    for j := 0 to Length(resv[0]) - 1 do
    begin
      if j = 0 then
        resv[k][j] := (39 * ValueArray[j * Coef + k] +
          8 * ValueArray[(j + 1) * Coef + k] - 4 * (ValueArray[(j + 2) * Coef +
            k] +
          ValueArray[(j + 3) * Coef + k] - ValueArray[(j + 4) * Coef + k]) +
          ValueArray[(j + 5) * Coef + k] - 2 * ValueArray[(j + 6) * Coef + k]) /
            42;
      if j = 1 then
        resv[k][j] := (8 * ValueArray[j * Coef + k] +
          19 * ValueArray[(j + 1) * Coef + k] + 16 * ValueArray[(j + 2) * Coef +
            k] +
          6 * ValueArray[(j + 3) * Coef + k] - 4 * ValueArray[(j + 4) * Coef + k]
            -
          7 * ValueArray[(j + 5) * Coef + k] + 4 * ValueArray[(j + 6) * Coef +
            k]) / 42;
      if j = 2 then
        resv[k][j] := (-4 * ValueArray[j * Coef + k] +
          16 * ValueArray[(j + 1) * Coef + k] + 19 * ValueArray[(j + 2) * Coef +
            k] +
          12 * ValueArray[(j + 3) * Coef + k] + 2 * ValueArray[(j + 4) * Coef +
            k] -
          4 * ValueArray[(j + 5) * Coef + k] + ValueArray[(j + 6) * Coef + k]) /
            42;
      if (j > 2) and (j < Length(resv[0]) - 3) then
        resv[k][j] :=
          (7 * ValueArray[j * Coef + k] + 6 * (ValueArray[(j - 1) * Coef + k] +
          ValueArray[(j + 1) * Coef + k]) + 3 * (ValueArray[(j - 2) * Coef + k]
            +
          ValueArray[(j + 2) * Coef + k]) - 2 * (ValueArray[(j - 3) * Coef + k]
            +
          ValueArray[(j + 3) * Coef + k])) / 21;
      if j = Length(resv[0]) - 3 then
        resv[k][j] := (-4 * ValueArray[j * Coef + k] +
          16 * ValueArray[(j - 1) * Coef + k] + 19 * ValueArray[(j - 2) * Coef +
            k] +
          12 * ValueArray[(j - 3) * Coef + k] + 2 * ValueArray[(j - 4) * Coef +
            k] -
          4 * ValueArray[(j - 5) * Coef + k] + ValueArray[(j - 6) * Coef + k]) /
            42;
      if j = Length(resv[0]) - 2 then
        resv[k][j] := (8 * ValueArray[j * Coef + k] +
          19 * ValueArray[(j - 1) * Coef + k] + 16 * ValueArray[(j - 2) * Coef +
            k] +
          6 * ValueArray[(j - 3) * Coef + k] - 4 * ValueArray[(j - 4) * Coef + k]
            -
          7 * ValueArray[(j - 5) * Coef + k] + 4 * ValueArray[(j - 6) * Coef +
            k]) / 42;
      if j = Length(resv[0]) - 1 then
        resv[k][j] := (39 * ValueArray[j * Coef + k] +
          8 * ValueArray[(j - 1) * Coef + k] - 4 * ValueArray[(j - 2) * Coef + k]
            -
          4 * ValueArray[(j - 3) * Coef + k] - 4 * ValueArray[(j - 4) * Coef + k]
            +
          ValueArray[(j - 5) * Coef + k] - 2 * ValueArray[(j - 6) * Coef + k]) /
            42;
    end;
  for j := Coef to Length(resv[0]) - Coef do
    for k := 0 to Coef - 1 do
      ValueArray[j * Coef + k] := resv[k][j];
end;

//Фильтр с кубическими сплайнами

procedure CubicSplineSmoothing(var ValueArray: TDDoubleArray; Dsc: double;
  Coef: integer);
var
  j, k, i, N: integer;
  vresv, resv: array of array of double;
  maxv: array of double;
  av, h, mi, mj, v1, v2: double;
begin
  if (Coef = 0) or (Coef = 1) then
    Exit;
  N := Length(ValueArray);
  SetLength(resv, Coef, N);
  h := Coef * Dsc;
  for k := 0 to Coef - 1 do
    for j := 0 to (N div Coef) - 2 do
    begin
      if j = 0 then
      begin
        mi := (4 * ValueArray[(j + 1) * Coef + k] -
          ValueArray[(j + 2) * Coef + k] - 3 * ValueArray[j * Coef + k]) / 2;
        mj := (ValueArray[(j + 2) * Coef + k] - ValueArray[j * Coef + k]) / 2;
      end;
      if j = (N div Coef) - 2 then
      begin
        mi := (ValueArray[(j + 1) * Coef + k] - ValueArray[(j - 1) * Coef + k])
          / 2;
        mj := (3 * ValueArray[(j + 1) * Coef + k] + ValueArray[(j - 1) * Coef +
          k] -
          4 * ValueArray[j * Coef + k]) / 2;
      end;
      if (j > 0) and (j < ((N div Coef) - 2)) then
      begin
        mi := (ValueArray[(j + 1) * Coef + k] - ValueArray[(j - 1) * Coef + k])
          / 2;
        mj := (ValueArray[(j + 2) * Coef + k] - ValueArray[j * Coef + k]) / 2;
      end;
      for i := j * Coef to (j + 1) * Coef do
      begin
        v1 := ((j + 1) * Coef + k) * Dsc - (i + k) * Dsc;
        v2 := (i + k) * Dsc - (j * Coef + k) * Dsc;
        resv[k][i + k] := (Sqr(v1) * (2 * v2 + h) * ValueArray[j * Coef + k] +
          Sqr(v2) * (2 * v1 + h) * ValueArray[(j + 1) * Coef + k] +
          (Sqr(v1) * v2 * mi + Sqr(v2) * (-v1) * mj) / 2) / h / h / h;
      end;
    end;
  for j := Coef to N - 1 - Coef do
  begin
    av := 0;
    for k := 0 to Coef - 1 do
      av := av + resv[k][j];
    av := av / Coef;
    ValueArray[j] := av;
  end;
end;

//Гармонический синтез Фурье

procedure FourierAnalysis(var ValueArray: TDDoubleArray; NumGarmonics: integer);
var
  i, j, N: integer;
  yn, ap, bp: double;
  AFCoef, BFCoef: TDDoubleArray;
begin
  N := Length(ValueArray);
  SetLength(AFCoef, NumGarmonics);
  SetLength(BFCoef, NumGarmonics);
  AFCoef[0] := Sum(ValueArray) / N;
  BFCoef[0] := 0;
  for i := 1 to NumGarmonics - 1 do
  begin
    AFCoef[i] := 0;
    BFCoef[i] := 0;
    for j := 0 to N - 1 do
    begin
      AFCoef[i] := AFCoef[i] + ValueArray[j] * cos(Pi * i * j * 2 / N);
      BFCoef[i] := BFCoef[i] + ValueArray[j] * sin(Pi * i * j * 2 / N);
    end;
    AFCoef[i] := AFCoef[i] * 2 / N;
    BFCoef[i] := BFCoef[i] * 2 / N;
  end;
  for j := 0 to N - 1 do
  begin
    yn := 0;
    ap := 0;
    bp := 0;
    for i := 1 to NumGarmonics - 1 do
    begin
      ap := ap + AFCoef[i] * cos(2 * Pi * i * (j / N));
      bp := bp + BFCoef[i] * sin(2 * Pi * i * (j / N));
    end;
    yn := AFCoef[0] + ap + bp;
    ValueArray[j] := yn;
  end;
end;

//Общая процедура вызова нужного фильтра

procedure DoArraySmoothing(var ValueArray: TDDoubleArray; FilterType: integer;
  Dsc: double; SplitCoef, ExpandCoef: integer; CycledFilter: boolean);
var
  j: integer;
begin
  ValueArray := ArrayExpanding(ValueArray, ExpandCoef);
  if FilterType = 1 then
    if CycledFilter then
      for j := 2 to SplitCoef do
        SevenPointNonLinearSmoothing(ValueArray, Dsc, j)
    else
      SevenPointNonLinearSmoothing(ValueArray, Dsc, SplitCoef);
  if FilterType = 2 then
    CubicSplineSmoothing(ValueArray, Dsc, SplitCoef);
  ArrayShortening(ValueArray, SplitCoef);
end;

//Расширение массива заданным числом точек справа и слева

procedure ArrayLengthening(var ValueArray: TDDoubleArray; SplitValue: integer);
var
  sv, N, i: integer;
  bv, ev: double;
begin
  N := Length(ValueArray);
  sv := 10 * SplitValue;
  bv := 0;
  ev := 0;
  for i := 0 to 9 do
    bv := bv + ValueArray[i];
  bv := bv / 10;
  for i := N - 1 downto N - 10 do
    ev := ev + ValueArray[i];
  ev := ev / 10;
  SetLength(ValueArray, N + sv);
  for i := N - 1 downto 0 do
    ValueArray[i + trunc(sv / 2)] := ValueArray[i];
  for i := trunc(sv / 2) - 1 downto 0 do
    ValueArray[i] := bv;
  for i := N + trunc(sv / 2) to N + sv - 1 do
    ValueArray[i] := ev;
end;

//Сокращение массива заданным числом точек справа и слева

procedure ArrayShortening(var ValueArray: TDDoubleArray; SplitValue: integer);
var
  sv, N, i: integer;
begin
  N := Length(ValueArray);
  sv := 10 * SplitValue;
  for i := 0 to N - sv - 1 do
    ValueArray[i] := ValueArray[i + trunc(sv / 2)];
  SetLength(ValueArray, N - sv);
end;

//Расширение массива заданным числом точек между 2-мя соседними

function ArrayExpanding(var ValueArray: TDDoubleArray; ExpandCoef: integer): TDDoubleArray;
var
  i, k, N, sub: integer;
  diap: double;
begin
  N := Length(ValueArray);
  sub := ExpandCoef - 1;
  SetLength(Result, N * ExpandCoef - sub);
  for i := 0 to N - 1 do
  begin
    Result[i * ExpandCoef] := ValueArray[i];
    if i <> 0 then
    begin
      diap := (Result[i * ExpandCoef] - Result[(i - 1) * ExpandCoef]);
      for k := 0 to ExpandCoef - 1 do
        Result[(i - 1) * ExpandCoef + k] :=
          Result[(i - 1) * ExpandCoef] + diap * (k / ExpandCoef);
    end;
  end;
end;

//Общая процедура проверки массива

procedure CheckArrayBounds(var CArray: TDDoubleArray; var FromPoint, ToPoint:
  integer);
begin
  if FromPoint < 0 then
    FromPoint := 0;
  if (ToPoint <= 0) or (ToPoint > Length(CArray) - 1) then
    ToPoint := Length(CArray) - 1;
  if FromPoint > ToPoint then
    ToPoint := FromPoint;
end;



//Вычисление площади под кривой, получаемой данными из массива

function CalculateAreaOfArray(var SourceArray: TDDoubleArray;
  FromPoint, ToPoint, Method: integer; BindToZero: boolean): double;
var
  i: integer;
  sq, subv: double;
  rv: TDDoubleArray;
begin
  if SourceArray = nil then
    CalculateAreaOfArray := 0
  else
  begin
    CheckArrayBounds(SourceArray, FromPoint, ToPoint);
    sq := 0;
    if BindToZero then
      subv :=
        (SourceArray[ToPoint] + SourceArray[FromPoint]) / 2
      else
      subv := 0;
    for i := FromPoint to ToPoint - 1 do
    begin
      if Method = 1 then
        sq := sq + Abs(SourceArray[i] - subv) +
          (Abs(SourceArray[i + 1] - subv) - Abs(SourceArray[i] - subv)) / 2;
      if Method = 2 then
        sq := sq + Abs(SourceArray[i] - subv) +
          (Abs(SourceArray[i + 1] - subv) - Abs(SourceArray[i] - subv)) / 2 - 1
            / (48 * Power(0.5, 1.5));
      if Method = 3 then
        if (i mod 2) = 1 then
          sq := sq + 2 * Abs(SourceArray[i] - subv);
      if Method = 4 then
        if (i mod 2) = 1 then
          sq := sq + 2 * Abs(SourceArray[i] - subv) - 1 / (96 * Power(0.5,
            1.5));
    end;
    CalculateAreaOfArray := sq;
  end;
end;


//Исключение линейной составляющей

procedure LinearTrendExclusion(var ValueArray: TDDoubleArray);
var
  i, N: integer;
  b0, b1, nx: double;
begin
  N := Length(ValueArray);
  nx := 0;
  for i := 0 to N - 1 do
    nx := nx + (i + 1) * ValueArray[i];
  b0 := (2 * (2 * N + 1) * Sum(ValueArray) - 6 * nx) / (N * (N - 1));
  b1 := (12 * nx - 6 * (N + 1) * Sum(ValueArray)) / (N * (N - 1) * (N + 1));
  for i := 0 to N - 1 do
  begin
    ValueArray[i] := ValueArray[i] - (i * b1);
  end;
end;


end.
