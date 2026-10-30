from sqlalchemy.orm import Session

from models import Document
from schemas import DocumentCreate


def get_document(db: Session, document_id: int):
    return (
        db.query(Document)
        .filter(Document.document_id == document_id)
        .first()
    )


def get_documents(db: Session, skip: int = 0, limit: int = 100):
    return (
        db.query(Document)
        .offset(skip)
        .limit(limit)
        .all()
    )


def create_document(db: Session, document: DocumentCreate):
    db_document = Document(**document.model_dump())

    db.add(db_document)
    db.commit()
    db.refresh(db_document)

    return db_document
