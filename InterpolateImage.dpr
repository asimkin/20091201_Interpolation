program InterpolateImage;

uses
  Forms,
  UnitInt in 'UnitInt.pas' {Form2},
  ImgLibImpl in 'ImgLibImpl.pas',
  ImgLibTypes in 'ImgLibTypes.pas',
  ImgLibArrayExt in 'ImgLibArrayExt.pas',
  SplineLibLinear in 'SplineLibLinear.pas',
  SplineLibBilinear in 'SplineLibBilinear.pas',
  QPixels in 'QPixels.pas',
  ImgLibImageExt in 'ImgLibImageExt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
