object fmConexaoBancoDados: TfmConexaoBancoDados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Conex'#227'o com o banco de dados'
  ClientHeight = 221
  ClientWidth = 584
  Color = clBtnFace
  Constraints.MaxHeight = 260
  Constraints.MaxWidth = 600
  Constraints.MinHeight = 250
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object paCentro: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 221
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 261
    object lbTitulo: TLabel
      Left = 8
      Top = 0
      Width = 192
      Height = 17
      Caption = 'Nova configura'#231#227'o do servidor:'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lbCaminhoBancoDados: TLabel
      Left = 16
      Top = 24
      Width = 213
      Height = 15
      Caption = 'Caminho do banco de dados / servidor *'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lbUsuarioBancoDados: TLabel
      Left = 16
      Top = 72
      Width = 152
      Height = 15
      Caption = 'Usu'#225'rio do banco de dados *'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lbSenhaBancoDados: TLabel
      Left = 16
      Top = 117
      Width = 145
      Height = 15
      Caption = 'Senha do banco de dados *'
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object edCaminhoServidor: TMaskEdit
      Left = 16
      Top = 40
      Width = 400
      Height = 23
      TabOrder = 0
      Text = ''
      TextHint = 'Forne'#231'a o caminho do banco de dados...'
    end
    object edUsuarioBD: TMaskEdit
      Left = 16
      Top = 88
      Width = 400
      Height = 23
      CharCase = ecUpperCase
      TabOrder = 1
      Text = ''
    end
    object edSenhaBD: TMaskEdit
      Left = 16
      Top = 133
      Width = 400
      Height = 23
      CharCase = ecLowerCase
      PasswordChar = '*'
      TabOrder = 2
      Text = ''
    end
    object btSelecionar: TButton
      Left = 424
      Top = 38
      Width = 75
      Height = 25
      Caption = 'Selecionar'
      TabOrder = 3
      OnClick = btSelecionarClick
    end
    object btExibir: TButton
      Left = 424
      Top = 131
      Width = 75
      Height = 25
      Caption = 'Exibir'
      TabOrder = 4
      OnClick = btExibirClick
    end
    object btSalvar: TButton
      Left = 16
      Top = 179
      Width = 75
      Height = 25
      Caption = 'Salvar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ModalResult = 1
      ParentFont = False
      TabOrder = 5
      OnClick = btSalvarClick
    end
    object btCancelar: TButton
      Left = 109
      Top = 179
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 6
      OnClick = btCancelarClick
    end
  end
  object OpenDialog: TOpenDialog
    Left = 516
    Top = 161
  end
end
