object Form2: TForm2
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Interpolate Image'
  ClientHeight = 329
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 457
    Height = 329
    Caption = 'Original'
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Top = 16
      Width = 454
      Height = 310
      Proportional = True
      Stretch = True
      OnMouseDown = Image1MouseDown
      OnMouseMove = Image1MouseMove
      OnMouseUp = Image1MouseUp
    end
    object Panel1: TPanel
      Left = 312
      Top = 237
      Width = 142
      Height = 89
      TabOrder = 0
      Visible = False
      object Label1: TLabel
        Left = 8
        Top = 11
        Width = 7
        Height = 13
        Caption = 'H'
      end
      object Label2: TLabel
        Left = 8
        Top = 35
        Width = 10
        Height = 13
        Caption = 'W'
      end
      object EditH: TEdit
        Left = 30
        Top = 8
        Width = 105
        Height = 21
        TabOrder = 0
        OnChange = EditHChange
      end
      object EditW: TEdit
        Left = 30
        Top = 35
        Width = 105
        Height = 21
        TabOrder = 1
        OnChange = EditWChange
      end
      object CheckBox1: TCheckBox
        Left = 29
        Top = 62
        Width = 97
        Height = 17
        Caption = 'Proportional'
        TabOrder = 2
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 463
    Top = 0
    Width = 457
    Height = 329
    Caption = 'Interpolate'
    TabOrder = 1
    object Image2: TImage
      Left = 0
      Top = 16
      Width = 454
      Height = 310
      IncrementalDisplay = True
      Proportional = True
      Stretch = True
    end
    object Panel2: TPanel
      Left = 3
      Top = 265
      Width = 129
      Height = 61
      TabOrder = 0
      Visible = False
      object Label16: TLabel
        Left = 103
        Top = 15
        Width = 13
        Height = 13
        Caption = 'ms'
      end
      object LabelPerfomance: TLabel
        Left = 11
        Top = 39
        Width = 68
        Height = 13
        Caption = 'Speed: ??? ms'
      end
      object EditPerfomance: TEdit
        Left = 8
        Top = 12
        Width = 89
        Height = 21
        TabOrder = 0
        Text = '?'
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 152
    object df1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
      object Saveas1: TMenuItem
        Caption = 'Save result as...'
        OnClick = Saveas1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Interpolate1: TMenuItem
      Caption = 'Preferences'
      object N11: TMenuItem
        Caption = 'Interpolate'
        object Linear1: TMenuItem
          Caption = 'Bilinear'
          Checked = True
          OnClick = Linear1Click
        end
        object Cubic1: TMenuItem
          Caption = 'Bicubic'
          OnClick = Cubic1Click
        end
        object Akima1: TMenuItem
          Caption = 'Biakima'
          OnClick = Akima1Click
        end
        object all: TMenuItem
          Caption = 'All'
          Visible = False
          OnClick = allClick
        end
      end
      object ResizePanel1: TMenuItem
        Caption = 'ResizePanel'
        OnClick = ResizePanel1Click
      end
      object SpeedTestPanel1: TMenuItem
        Caption = 'SpeedTestPanel'
        OnClick = SpeedTestPanel1Click
      end
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Left = 80
  end
  object SavePictureDialog: TSavePictureDialog
    Left = 112
  end
end
