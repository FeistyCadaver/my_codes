USE Tour
GO

CREATE PROCEDURE usp_AnalyzeHotelPartner
    @hotel_id INT
AS
BEGIN
    SELECT
        hotel_name AS 'Отель',
        total_bookings AS 'Бронирований',
        cancelled_bookings AS 'Отмен',
        (cancelled_bookings * 100 / total_bookings) AS 'Доля отмен %'
    FROM hotel_partners
    WHERE id_hotel = @hotel_id;
END
GO
EXEC usp_AnalyzeHotelPartner 1;