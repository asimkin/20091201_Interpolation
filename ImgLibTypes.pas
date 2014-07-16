{*******************************************************}
{                                                       }
{      Image Library for Bachelor Diploma Project       }
{               MSTU n.a. Bauman, ICS-1                 }
{           Copyright (c) 2009, Simkin A.V.             }
{                                                       }
{*******************************************************}
{         Library Version 0.8.7 from 25.04.2009         }
{*******************************************************}
{   'Variables, Constantes and Types' from 25.04.2009   }
{*******************************************************}
unit ImgLibTypes;
 { ������ ���������� �����, �������� � ���������� ���������� }
interface {�������� ��������� ������}

  uses
  ////////////////////////////////////////////////////////////
  // ������������ ������� ������
  //
  Windows; // ��������� ������

  type
  ////////////////////////////////////////////////////////////
  // �������������� ����
  //
    //////////////////////////////////////////////////////
    // ����� � �������� ����
    //// ������� � �������� ������� ���������� ////
    // ��������� �� �������� ����
    PDouble = ^Double;
    // ������� �������
    TDBooleanArray      = array of Boolean;
    TDBoolean2Array     = array of TDBooleanArray;
    TDByteArray         = array of Byte;
    TDWordArray         = array of Word;
    TDCardinalArray     = array of Cardinal;
    TDIntegerArray      = array of LongInt;
    TDInteger2Array     = array of TDIntegerArray;
    TDDoubleArray       = array of Double;
    TDDouble2Array      = array of TDDoubleArray;
    TDStringArray       = array of String;
    TDString2Array      = array of TDStringArray;
    // �������� ������� (������ ��������� ���������� �� �����������) //
    TImageArray         = array of TDByteArray;     // "�����������" ��� ������ �������� 8 �������� ����������� (������������)
    TImagesArray        = array of TImageArray;    // ������ ����������� ��� ������ ������� ��������
    TLevelsArray        = array[0..MAXBYTE] of Cardinal; // ������ ������������� ������� �����������
    TBrightnessArray    = TDByteArray;                    // ������ �������� �������� �����������

    //// �������� ������ ���������� ////
    // ������ �����������
    TSymbol             = Record //������ �������
      img      : TImageArray; // �����������
      symbol   : Char;        // �������������� ������
      hit      : Double;      // *100%, ������� ��������� ��������
      position : Word;        // ������� ������� � ������������ �������
    End; // TSymbol
    // ������ ���������� ��������
    TPointPosition      = Record // ������ ���������������� �����
      i, j: Cardinal // ������ 2 ����� ��������
    End; // TPointPosition
    TPointParameters    = Record // ������ ���������� �����
      gx,gy : Byte;   // ��������
      p     : Word;   // ����� sqrt(gx^2+gy^2)
      fi    : Single; // ���� arctan2(gy,gx)
    End; // TPointParameters
    TMargins = Record // ������ ������ ����� ���� �������
        right, buttom, left, top: Word;
    End; // TMargins

    //// ������� �������� ������� ////
    TSymbolsArray       = array of TSymbol;          // ������ ���������� ������ ��������
    TPointPosArray      = array of TPointPosition;   // ������ ���������
    TPointPos2Array     = array of TPointPosArray;   // ������ ������� ���������
    TPointParArray      = array of TPointParameters; // ������ ���������� ���������
    TPointPar2Array     = array of TPointParArray;   // ��������� ������ ���������� ��������

    //////////////////////////////////////////////////////
    // ���� �������������
    //// ������������� ���� ////
    TSymbolSize         = (s32, s16, s8); // ������������ �������� ������� ������� (������� ��� �������������)
    TCountryIndex       = (RUS); // ���� ������� ������ ������
    //// ������ ////
    TRecognizeSetting   = Record // ������ �������� ������� ��� ������������� ������
      MaxSymbols    : Byte;     // ������������ ���������� �������� � ������� �������������
      MinSymbols    : Byte;     // ����������� ���������� �������� � ������� �������������
      cfMaxRectangle: Double;   // ������������ ��������� ������ ������ � ������
      cfMinRectangle: Double;   // ����������� ��������� ������ ������ � ������
      cfSymbolWidth : Double;   // ����������� ������ ������� � ������ ������
      cfSymbolHeight: Double;   // ����������� ������ ������� � ������ ������
      cfSymbolSpace : Double;   // ����������� ������ ������� ������� � ������ ������
      cfMaxBright   : Double;   // *100%, �������� � % �� ������������ ������� ������������������ ��� ���������� ���������
      case CountryIndex: TCountryIndex of // ���������� ����� ������
       RUS: ( // ��� ������� (������)
             MinSeriesSymbols: Byte; // ����������� ���. �������� � ������� �����
             MinRegionSymbols: Byte; // ����������� ���. �������� � ������� �������
             cfSeriesMax: Double;    // ����������� max ������ ������� ����� � ������ ������
             cfSeriesMin: Double;    // ����������� min ������ ������� ����� � ������ ������
             cfRegionH: Double;      // ����������� ������ ������� ������� � ������ ������
             cfRegionW: Double;      // ����������� ������ ������� ������� � �� ������
             cfLineW  : Double;      // ����������� ������ ������� ����� � ������ ������
             );
    End; // TRecognizeSetting
    //// ������� ////
    TSizeSymbolsArray   = array[TSymbolSize] of TSymbolsArray; // ������ ���������� ����������� �������� �� ������� ������� �������
    TCountrySettings    = array[TCountryIndex] of TRecognizeSetting; //������ �������� ������������� �� ������ ������

    //////////////////////////////////////////////////////
    // �������������� ����
    //// �������� ���� ������ � ��������� ////
    // ������������� ����
    TFindType           = (mLinear, mBinary); // �������� ��������� ������ � �������
    TBWFilterType       = (fBlackMass, fFindMin);  // ���� BW �������
    TSplineType         = (fLinear, fHermite, fCubic, fAkima, fBilinear, fBicubic, fBiakima); // ���� ������������
    TSmoothingType      = (fSevenNonLinear, fCubicSpline); // ���� ����������� �������
    TResizeType         = (fAverageArea, fBilinearSpline, fBicubicSpline, fBiakimaSpline); // ���� ���������� ��� ��������� �������

  const
  ////////////////////////////////////////////////////////////
  // �������� ��������� ������
  //
    // ��������� ������������� //
    cAgreeHits          = 0.75; // *100%, ��������, ��� ������� ������ ��������� �����������

  Var
  ////////////////////////////////////////////////////////////
  // �������� ���������� ������
  //
    // ��������� ������������� //
    CountrySettings: TCountrySettings;

  ////////////////////////////////////////////////////////////
  // �������� ��������� � ������� ������
  //
  function GetTSymbolSize(SymbolSize: TSymbolSize): Word; stdcall;

implementation {���������� ������}

////////////////////////////////////////////////////////////////////////////////
//// ��������� ��������� � �������
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ��������� � ������� ���������� ���������� ������
//

// ��������� ���������� ���������� CountrySettings ���������� ����������
 procedure FillCountrySettings(); safecall;
 Var RecognizeSetting: TRecognizeSetting;
 Begin
  // RUS //
  with RecognizeSetting do
  begin
    CountryIndex      := RUS;
    MaxSymbols        := 9;
    MinSymbols        := 8;
    cfMaxRectangle    := 5.5;
    cfMinRectangle    := 4.0;
    MinSeriesSymbols  := 5;
    MinRegionSymbols  := 2;
    cfSymbolHeight    := 0.80;
    cfSymbolWidth     := 0.60; // 0.55
    cfSymbolSpace     := 0.20;
    cfSeriesMax       := 4.0;
    cfSeriesMin       := 3.0;
    cfMaxBright       := 0.88;
    cfRegionH         := 0.70;
    cfRegionW         := 2.0;
    cfLineW           := 0.08;
  end;
  CountrySettings[RUS] := RecognizeSetting;
 End; // FillCountrySettings();



////////////////////////////////////////////////////////////////////////////////
//// ��������� � ������� ��������� �����
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
// ���� �������������
//

// ������� ���������� �������� ������� ��� TSymbolSize
// !������� ����� �������� �� ������ �������� (��. �����������)
// ���������:
//  SymbolSize - �������� �������������� ����
// ������������ ��������:
//  Word - �������� �������
 function GetTSymbolSize(SymbolSize: TSymbolSize): Word;
 //var S: String;
 begin
   Result := 0;
   // 1�� ������� ������ (����� �������)
   case SymbolSize of
    s32: Result := 32;
    s16: Result := 16;
    s8 : Result := 8;
   end;
   {// 2�� ������� ������  // ������� unit "TypInfo" � uses
   S      := GetEnumName(TypeInfo(TSymbolSize), Ord(SymbolSize));
   Result := StrToInt(Copy(S, 2, Length(S) - 1)); }
 end; // GetTSymbolSize();


initialization {��������� ����������� ���� ��� ��� ������ ��������� � ������}

 // ��������� ���������� CountrySettings
 FillCountrySettings();

finalization {���������, ����������� ��� ����� ���������� ������ ������}

end. // ImgLibTypes
