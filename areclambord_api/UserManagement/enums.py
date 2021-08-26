from enum import Enum


class BillboardUserType(Enum):
    CUSTOMER = "Customer"
    VENDOR = "Vendor"
    ADMIN = "Admin"

    @classmethod
    def choices(cls):
        return [(key.value, key.name) for key in cls]


# billboard_enums
class BillboardType(Enum):
    WIDE = "Wide"
    ULTRAWIDE = "Ultra"
    SMALL = "Small"

    @classmethod
    def choices(cls):
        return [(key.value, key.name) for key in cls]


# advertisement enums
class AdvertisementPackageType(Enum):
    GOLD = "Gold"
    PREMIUM = "Premium"
    SILVER = "Silver"

    @classmethod
    def choices(cls):
        return [(key.value, key.name) for key in cls]
