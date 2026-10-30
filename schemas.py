from datetime import date
from pydantic import BaseModel, ConfigDict


class DocumentCreate(BaseModel):
    document_type: str
    document_number: str | None = None
    first_name: str | None = None
    last_name: str | None = None
    image_path: str | None = None
    dob: date | None = None
    issue_date: date | None = None
    exp_date: date | None = None
    street_address: str | None = None
    city: str | None = None
    state: str | None = None
    zip_code: str | None = None
    sex: str | None = None
    eye_color: str | None = None
    hair_color: str | None = None
    weight: str | None = None
    height: str | None = None


class DocumentResponse(DocumentCreate):
    document_id: int

    model_config = ConfigDict(from_attributes=True)
