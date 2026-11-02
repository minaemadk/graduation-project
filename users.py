# users.py
from auth import get_current_user
from fastapi import APIRouter, Depends
from schemas import PasswordChange, UserResponse, UserUpdate

router = APIRouter(prefix="/users", tags=["Users & Account Management"])


@router.get("/me", response_model=UserResponse)
def get_current_user_profile(current_user: str = Depends(get_current_user)):

  pass


@router.put("/me", response_model=UserResponse)
def update_user_profile(
    user_update: UserUpdate, current_user: str = Depends(get_current_user)
):

  pass


@router.put("/me/password")
def change_password(
    body: PasswordChange, current_user: str = Depends(get_current_user)
):
  pass