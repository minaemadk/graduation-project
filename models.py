from sqlalchemy import Column, Integer, String, Unicode, Date
from sqlalchemy.orm import declarative_base

Base = declarative_base()


class Document(Base):
    __tablename__ = "Document"
    __table_args__ = {"schema": "dbo"}

    document_id = Column(Integer, primary_key=True, autoincrement=True)
    document_type = Column(String(30), nullable=False)
    document_number = Column(String(50), nullable=True)
    first_name = Column(Unicode(100), nullable=True)
    last_name = Column(Unicode(100), nullable=True)
    image_path = Column(Unicode(500), nullable=True)
    dob = Column(Date, nullable=True)
    issue_date = Column(Date, nullable=True)
    exp_date = Column(Date, nullable=True)
    street_address = Column(Unicode(250), nullable=True)
    city = Column(Unicode(100), nullable=True)
    state = Column(Unicode(100), nullable=True)
    zip_code = Column(String(20), nullable=True)
    sex = Column(Unicode(20), nullable=True)
    eye_color = Column(String(30), nullable=True)
    hair_color = Column(String(30), nullable=True)
    weight = Column(Unicode(20), nullable=True)
    height = Column(Unicode(20), nullable=True)
