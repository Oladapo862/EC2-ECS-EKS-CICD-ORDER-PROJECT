from db import get_connection


def create_order():
    connection = get_connection()

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                CREATE TABLE IF NOT EXISTS orders (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    status VARCHAR(50) NOT NULL
                )
                """
            )

            cursor.execute(
                "INSERT INTO orders (status) VALUES (%s)",
                ("created",)
            )

            connection.commit()

            order_id = cursor.lastrowid

        return {
            "order_id": order_id,
            "status": "created"
        }

    finally:
        connection.close()
