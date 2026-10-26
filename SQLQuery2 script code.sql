USE [DocVerifyDb]
GO
/****** Object:  Table [dbo].[Document]    Script Date: 10/26/2026 2:45:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Document](
	[document_id] [int] IDENTITY(1,1) NOT NULL,
	[document_type] [varchar](30) NOT NULL,
	[document_number] [varchar](50) NULL,
	[first_name] [nvarchar](100) NULL,
	[last_name] [nvarchar](100) NULL,
	[image_path] [nvarchar](500) NULL,
	[dob] [date] NULL,
	[issue_date] [date] NULL,
	[exp_date] [date] NULL,
	[street_address] [nvarchar](250) NULL,
	[city] [nvarchar](100) NULL,
	[state] [nvarchar](100) NULL,
	[zip_code] [varchar](20) NULL,
	[sex] [nvarchar](20) NULL,
	[eye_color] [nvarchar](30) NULL,
	[hair_color] [nvarchar](30) NULL,
	[weight] [nvarchar](20) NULL,
	[height] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[document_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Driver_License]    Script Date: 10/26/2026 2:45:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Driver_License](
	[document_id] [int] NOT NULL,
	[class_type] [varchar](30) NULL,
	[endorsements] [nvarchar](250) NULL,
	[restrictions] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[document_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Id_Card]    Script Date: 10/26/2026 2:45:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Id_Card](
	[document_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[document_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Verification]    Script Date: 10/26/2026 2:45:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Verification](
	[verification_id] [int] IDENTITY(1,1) NOT NULL,
	[document_id] [int] NOT NULL,
	[verification_date] [datetime2](7) NOT NULL,
	[status] [varchar](20) NOT NULL,
	[result] [varchar](10) NULL,
	[confidence_score] [decimal](4, 3) NULL,
PRIMARY KEY CLUSTERED 
(
	[verification_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Verification_Issues]    Script Date: 10/26/2026 2:45:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Verification_Issues](
	[issue_id] [int] IDENTITY(1,1) NOT NULL,
	[verification_id] [int] NOT NULL,
	[field_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[issue_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Verification] ADD  DEFAULT (sysdatetime()) FOR [verification_date]
GO
ALTER TABLE [dbo].[Verification] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[Driver_License]  WITH CHECK ADD  CONSTRAINT [FK_Driver_License_Document] FOREIGN KEY([document_id])
REFERENCES [dbo].[Document] ([document_id])
GO
ALTER TABLE [dbo].[Driver_License] CHECK CONSTRAINT [FK_Driver_License_Document]
GO
ALTER TABLE [dbo].[Id_Card]  WITH CHECK ADD  CONSTRAINT [FK_ID_Card_Document] FOREIGN KEY([document_id])
REFERENCES [dbo].[Document] ([document_id])
GO
ALTER TABLE [dbo].[Id_Card] CHECK CONSTRAINT [FK_ID_Card_Document]
GO
ALTER TABLE [dbo].[Verification]  WITH CHECK ADD  CONSTRAINT [FK_Verification_Document] FOREIGN KEY([document_id])
REFERENCES [dbo].[Document] ([document_id])
GO
ALTER TABLE [dbo].[Verification] CHECK CONSTRAINT [FK_Verification_Document]
GO
ALTER TABLE [dbo].[Verification_Issues]  WITH CHECK ADD  CONSTRAINT [FK_Verification_Issues_Verification] FOREIGN KEY([verification_id])
REFERENCES [dbo].[Verification] ([verification_id])
GO
ALTER TABLE [dbo].[Verification_Issues] CHECK CONSTRAINT [FK_Verification_Issues_Verification]
GO
ALTER TABLE [dbo].[Document]  WITH CHECK ADD CHECK  (([document_type]='Driver_License' OR [document_type]='ID_Card'))
GO
ALTER TABLE [dbo].[Verification]  WITH CHECK ADD CHECK  (([confidence_score] IS NULL OR [confidence_score]>=(0) AND [confidence_score]<=(1)))
GO
ALTER TABLE [dbo].[Verification]  WITH CHECK ADD CHECK  (([result]='fake' OR [result]='real'))
GO
ALTER TABLE [dbo].[Verification]  WITH CHECK ADD CHECK  (([status]='completed' OR [status]='pending'))
GO
ALTER TABLE [dbo].[Verification]  WITH CHECK ADD  CONSTRAINT [CK_Verification_Status_Result] CHECK  (([status]='pending' AND [result] IS NULL AND [confidence_score] IS NULL OR [status]='completed' AND [result] IS NOT NULL AND ([confidence_score] IS NULL OR [confidence_score]>=(0) AND [confidence_score]<=(1))))
GO
ALTER TABLE [dbo].[Verification] CHECK CONSTRAINT [CK_Verification_Status_Result]
GO
