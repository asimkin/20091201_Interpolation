unit UnitInt;

interface

uses
  Windows, 
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, ExtDlgs, JPEG,
  ImgLibTypes, ImgLibArrayExt, ImgLibImageExt, ImgLibImpl;

type
  TForm2 = class(TForm)
    MainMenu: TMainMenu;
    df1: TMenuItem;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    Interpolate1: TMenuItem;
    Linear1: TMenuItem;
    Cubic1: TMenuItem;
    Akima1: TMenuItem;
    all: TMenuItem;
    GroupBox1: TGroupBox;
    Image1: TImage;
    GroupBox2: TGroupBox;
    Image2: TImage;
    Saveas1: TMenuItem;
    Panel1: TPanel;
    N11: TMenuItem;
    ResizePanel1: TMenuItem;
    EditH: TEdit;
    EditW: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    OpenPictureDialog: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    Panel2: TPanel;
    Label16: TLabel;
    LabelPerfomance: TLabel;
    EditPerfomance: TEdit;
    SpeedTestPanel1: TMenuItem;
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Linear1Click(Sender: TObject);
    procedure Cubic1Click(Sender: TObject);
    procedure Akima1Click(Sender: TObject);
    procedure allClick(Sender: TObject);
    procedure ResizePanel1Click(Sender: TObject);
    procedure EditHChange(Sender: TObject);
    procedure EditWChange(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure SpeedTestPanel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2         : TForm2;
  FileName      : TFileName;
  BMP, BMPInter : TBitmap;
  KPorp         : double;
  recO, recI    : TRect;
  x0, y0, x1, y1: integer;
  move1, move2: boolean;

implementation

{$R *.dfm}

procedure ClearMainInterpolate;
begin
  with Form2 do begin
    Cubic1.Checked  := False;
    Akima1.Checked  := False;
    all.Checked     := False;
    Linear1.Checked := False;
  end;
end;

procedure Interpolate;
var
    bTime, eTime: TDateTime;
    h, m, s, ms: word;
begin
  BMPInter.Free;
  //BMPInter := TBitMap.Create;
  if Form2.Panel2.Visible then bTime := GetTime;
  if Form2.Cubic1.Checked then begin
    BMPInter := iResize(BMP, StrToInt(Form2.EditH.Text), StrToInt(Form2.EditW.Text), fBicubicSpline, False);
  end
  else if Form2.Akima1.Checked then begin
    BMPInter := iResize(BMP, StrToInt(Form2.EditH.Text), StrToInt(Form2.EditW.Text), fBiakimaSpline, False);
  end
  else if Form2.Linear1.Checked then begin
    BMPInter := iResize(BMP, StrToInt(Form2.EditH.Text), StrToInt(Form2.EditW.Text), fBilinearSpline, False);
  end
  else if Form2.all.Checked then begin

  end;
  if Form2.Panel2.Visible then begin
    eTime := GetTime - bTime;
    decodetime(eTime, h, m, s, ms);
    Form2.LabelPerfomance.Caption := 'Speed: ' + IntToStr(m) + ' m,' + IntToStr(s) + ' s,' + IntToStr(ms) + ' ms';
    Form2.EditPerfomance.Text := IntToStr(m*60*1000 + s*1000 + ms);
  end;
  Form2.Image2.Picture.Bitmap.Assign(BMPInter);
end;

procedure TForm2.Akima1Click(Sender: TObject);
begin
  ClearMainInterpolate;
  Akima1.Checked := True;
  Interpolate;
end;

procedure TForm2.allClick(Sender: TObject);
begin
  ClearMainInterpolate;
  all.Checked := True;
  Interpolate;
end;

procedure TForm2.Cubic1Click(Sender: TObject);
begin
  ClearMainInterpolate;
  Cubic1.Checked := True;
  Interpolate;
end;

procedure TForm2.EditHChange(Sender: TObject);
begin
  if CheckBox1.Checked then EditW.Text := IntToStr(Round(StrToInt(EditH.Text)/KPorp));
end;

procedure TForm2.EditWChange(Sender: TObject);
begin
  if CheckBox1.Checked then EditH.Text := IntToStr(Round(StrToInt(EditW.Text)*KPorp));
end;

procedure TForm2.Exit1Click(Sender: TObject);
begin
  Halt;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  KPorp := 1;
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {if Button <> mbLeft then move1 := false
  else begin
    move1 := true;
    x0    := x;
    y0    := y;
    recO  := image1.BoundsRect; //запоминаем контур картинки
  end;}
end;

procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
{if move1 then
  begin
    Canvas.DrawFocusRect(recO); //рисуем рамку
    with recO do
    begin
      left:=Left+x-x0;
      top:=Top+y-y0;
      right:=right+x-x0;
      bottom:=bottom+y-y0;
      x0:=x;
      y0:=y; // изменяем координаты
    end;
    Canvas.DrawFocusRect(recO); // рисуем рамку на новом месте
  end;}
end;

procedure TForm2.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  {Canvas.DrawFocusRect(recO);
  with image1 do begin
    setbounds(recO.left+x-x0,recO.top+y-y0,width,height); //перемещаем картинку
    move1:=false;
  end; }
end;

procedure TForm2.Linear1Click(Sender: TObject);
begin
  ClearMainInterpolate;
  Linear1.Checked := True;
  Interpolate;
end;

procedure TForm2.Open1Click(Sender: TObject);
begin
  If OpenPictureDialog.Execute Then FileName := OpenPictureDialog.FileName;
  If FileName <> '' Then
    Begin
      BMP := iOpenFromFile(FileName);
      if BMP=nil then begin
        CreateMessageDialog('Not support this grafic format! Only .jpg, .bmp images', mtWarning, [mbOK]).ShowModal;
        Exit;
      end;
      Image1.Picture.Bitmap.Assign(BMP);
      EditH.Text := IntToStr(BMP.Height);    
      EditW.Text := IntToStr(BMP.Width);
      KPorp := StrToInt(EditH.Text)/StrToInt(EditW.Text);
    End;
end;

procedure TForm2.ResizePanel1Click(Sender: TObject);
begin
  ResizePanel1.Checked := not ResizePanel1.Checked;
  Panel1.Visible := ResizePanel1.Checked;
end;

procedure TForm2.Saveas1Click(Sender: TObject);
Var FileName : TFileName;
    FExt : shortstring;
    jpg : TJPEGImage;
begin
  if BMPInter = nil then Exit;
  if SavePictureDialog.Execute then begin
    FileName := SavePictureDialog.FileName;
    FExt := ExtractFileExt(FileName);
    if Uppercase(FExt) = '.BMP' then begin
      BMPInter.SaveToFile(FileName);
    end
    else if Uppercase(FExt) = '.JPG' then begin
      jpg := TJPEGImage.Create;
      jpg.CompressionQuality := 100;
      jpg.Assign(BMPInter);
      jpg.SaveToFile(FileName);
    end
    else begin
      CreateMessageDialog('You must choose .jpg or .bmp extention!', mtWarning, [mbOK]).ShowModal;
      Exit;
    end;
  end;
end;

procedure TForm2.SpeedTestPanel1Click(Sender: TObject);
begin
  SpeedTestPanel1.Checked := not SpeedTestPanel1.Checked;
  Panel2.Visible := SpeedTestPanel1.Checked;
end;

end.
